require 'spec_helper'

module AuthHelper
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryBot.create(:user)
    # user.confirm # or set a confirmed_at inside the factory. Only      necessary if you are using the "confirmable" module
    sign_in user
  end

  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:user]
    admin = FactoryBot.create(:user, role: 1)
    # user.confirm # or set a confirmed_at inside the factory. Only      necessary if you are using the "confirmable" module
    sign_in admin
  end
end