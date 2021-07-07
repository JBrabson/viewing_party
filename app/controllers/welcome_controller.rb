class WelcomeController < ApplicationController
  def index
    @welcome_message = 'Welcome to the (View)Party'
    @description = 'WHERE YOU CAN BRING THE MOVIE TO THE PARTY OR THE PARTY TO THE MOVIE'
  end
end
