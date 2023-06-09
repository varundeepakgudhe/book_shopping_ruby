class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :set_book, except: [:reviews_all]
  before_action :authenticate_user!
  before_action :check_authorization, only: [:edit, :update, :destroy]



  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all

    if params[:username] and params[:username] != ""
      @username = params[:username].strip
      @reviews = @reviews.select { |review| review.user.username == params[:username]}
    end

    if params[:bookname] and params[:bookname] != ""
      @bookname = params[:bookname].strip
      @reviews = @reviews.select { |review| review.book.name == params[:bookname]}
    end
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new

  end

  # GET /reviews/1/edit
  def edit

  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @review.book = @book
    @review.user = current_user
    respond_to do |format|
      if @review.save
        format.html { redirect_to book_path(@book), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to book_path(@book), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy
    redirect_to book_path(@book), notice: "Review was successfully destroyed."
    # respond_to do |format|
    #   format.html { redirect_to book_path(@book), notice: "Review was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
  def set_book
    @book = Book.find_by(id: params[:book_id])
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:id, :rating, :review)
    end

  def check_authorization
    if not current_user.admin? and not @review.user.id == current_user.id
      redirect_to root_path, alert: "You are not authorized for that action!"
    end
  end
end
