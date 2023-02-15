class AdminReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin_user?
  before_action :set_review, except: [:index, :new]
  def index
    @reviews = Review.all
    if params[:username] and params[:username] != ""
      @username = params[:username].strip
      @reviews = @reviews.select { |review| review.user.username == @username}
    end

    if params[:bookname] and params[:bookname] != ""
      @bookname = params[:bookname].strip
      @reviews = @reviews.select { |review| review.book.name == @bookname}
    end
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.create(review_params)

    if @review.save
      redirect_to admin_review_path(@review), notice: "Review created successfully"
    else
      render :new, notice: "something went wrong"
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      p "SDKLLKDJLK"
      redirect_to admin_review_path(@review), notice: "Review updated successfully"
    else
      p "SADKFLKFDJLKDS"
      render :edit, notice: "Something went wrong!"
    end
  end

  def destroy
    if @review.destroy
      redirect_to admin_reviews_path, notice: "Review deleted successfully!"
    else
      redirect_to admin_reviews_path, notice: "There was some error"
    end
  end

  def show
  end

  private
  def set_review
    @review = Review.find_by(id: params[:id])
  end

  def review_params
    params.require(:review).permit(:user_id, :book_id, :rating, :review)
  end
end
