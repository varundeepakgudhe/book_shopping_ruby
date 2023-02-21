class ApplicationController < ActionController::Base
  include ApplicationHelper
  private
  def is_admin_user?
    if not current_user.admin?
      redirect_to root_path, alert: "You are not authorized!"
    end
  end
end
