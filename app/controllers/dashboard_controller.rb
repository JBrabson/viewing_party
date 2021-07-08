class DashboardController < ApplicationController
  def index
    @user = User.find_by(session[:user_id])
  end
end
