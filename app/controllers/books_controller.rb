class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, :except => [:index, :show ]
  before_action :is_admin_user?, only: [:edit, :create, :new, :update, :destroy]
  # GET /books or /books.json
  def index
    @books = Book.all
    @order_item = current_order.order_items.new
    if params[:rating] and params[:rating] != ""
      @rating = Integer(params[:rating])
      @books = @books.select{|book| book.average_rating >= @rating}

    end

    if params[:author] and params[:author] != ""
      @author = params[:author].strip
      @books = @books.select{|book| book.author==@author}
    end

  end

  # GET /books/1 or /books/1.json
  def show
    @reviews = Book.find_by(id: params[:id]).reviews

    if params[:username] and params[:username] != ""
      @username = params[:username]
      @reviews = @reviews.select{|review| review.user.username==@username}
    end
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to admin_books_path, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:id, :name, :author, :publisher, :price, :stock)
    end
end
