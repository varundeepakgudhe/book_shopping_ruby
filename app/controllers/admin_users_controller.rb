class AdminUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin_user?

  def destroy
    @user = User.find_by(id: params[:id]).destroy
    redirect_to admin_users_path, notice: "User deleted successfully!"
  end

  def show
    @user = User.find_by(id: params[:id])
  end
  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    p @user
    puts " I am herer adfsadf"
    if @user.save
      redirect_to admin_users_path, notice: "New user created successfully!"
    else
      render :new, notice: "Something went wrong!"
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      redirect_to  admin_show_user_path(@user), notice: "User updated successfully!"
    else
      render :edit, notice: "Something went wrong!"
    end
  end

  private
  def is_admin_user?
    if not current_user.admin?
      redirect_to root_path, alert: "You are not authorized!"
    end
  end

  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username, :name, :address, :phone_number, :credit_card_number)
  end
end
