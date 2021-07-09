class DashboardController < ApplicationController
  def index
    @user = User.find_by(id: current_user.id)
    require 'pry'; binding.pry
  end
end
