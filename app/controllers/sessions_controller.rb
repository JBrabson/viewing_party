class SessionsController < ApplicationController
  def new
    @welcome_message = 'Welcome to View Party!'
    @register_message = 'REGISTER HERE TO BE A VIP OF VP'
    @user = User.new
  end
end
