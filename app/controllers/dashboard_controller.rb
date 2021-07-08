class DashboardController < ApplicationController
  def index
    @user = User.find_by(id: current_user.id)
  end
end
