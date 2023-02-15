class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin_user?
  def home
  end
end
