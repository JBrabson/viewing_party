class UsersController < ApplicationController
  def new
    @welcome_message = 'Register Below to Become a V.I.P. of VP!'
    @register_message = 'FILL OUT THE BELOW TO GET THIS PARTY STARTED'
    @user = User.new
  end

  def create
    user_params[:email] = user_params[:email].downcase
    new_user = User.create!(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome #{new_user.name}"
      redirect_to dashboard_path
    else
      registration_retry
    end
  end

  def registration_retry
    flash[:error] = 'Password and confirmation must match. Please try again.'
    redirect_to registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
