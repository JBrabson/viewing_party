class SessionsController < ApplicationController
  def new
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.name}"
      redirect_to dashboard_path
    else

    end
  end
end
