class DashboardController < ApplicationController
  def index
    @user = User.find_by(id: current_user.id)
    @friends = @user.friends
  end
end
