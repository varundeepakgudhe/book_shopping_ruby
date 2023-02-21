class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :is_admin_user?, only: [:edit, :update, :destroy]


  # GET /transactions or /transactions.json
  def index
    if current_user.id != nil
      @transactions = Transaction.where(user_id: current_user.id)
    else
      @transactions = Transaction.all
    end
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    if @book.nil? and !params[:book_id].nil?
      @book = Book.find(params[:book_id])
    end
    if !params[:order_id].nil?
      @order = current_order
    end

  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    # We create the transaction number using a random string of length 10
    @transaction.transaction_no = Array.new(10){[*"A".."Z", *"0".."9"].sample}.join

    if params[:transaction][:order_id].nil?
      @book = Book.find(params[:transaction][:book_id])
      @book.with_lock do

        puts(transaction_params)


        # We link the transaction to the current user and their credit card
        @transaction.user = current_user # insert the correct call to an appropriate function here

        # We update the original product quantity
        @remaining_stock = @book.stock - @transaction.quantity
        if @remaining_stock >= 0
          @book.stock = @remaining_stock
          @book.save
        else
          return redirect_to @book, alert: "You missed it, no stock left."
        end
        @transaction.book = @book

      end
    else
      @order_items = Order.find(params[:transaction][:order_id]).order_items
      @transaction.user = current_user # insert the correct call to an appropriate function here

      @order_items.each do |item|
        @book = Book.find(item.book.id)
        @remaining_stock = @book.stock - item.quantity
        if @remaining_stock >= 0
          @book.stock = @remaining_stock
          @transaction.book = @book
          @book.save
        else
          return redirect_to @book, alert: "You missed it, no stock left."
        end
      end
      @transaction.quantity = @order_items.size
      #@transaction.book_id = params[:transaction][:order_id]
      #@transaction.order = current_order
    end

    @transaction.phoneno = params[:transaction][:phone_number]
    @transaction.creditcard = params[:transaction][:credit_card]
    @transaction.address = params[:transaction][:address]

    if @transaction.save
      if params[:transaction][:order_id].nil?
        redirect_to @book, notice: "Transaction was successfully created."
      else
        redirect_to cart_path, notice: "Transaction was successfully created."
      end
    else
      render :new

    end

  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:quantity, :total_price, :credit_card,:address,:phone_number,:book_id, :user_id,:order_id)
  end


  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:transaction_no, :quantity, :total_price)
    end
end
