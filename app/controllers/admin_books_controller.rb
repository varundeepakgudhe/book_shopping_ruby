class AdminBooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin_user?
  def index
    @books = Book.all
    if params[:author] and params[:author] != ""
      @author = params[:author].strip
      @books = @books.select { |book| book.author == @author}
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
