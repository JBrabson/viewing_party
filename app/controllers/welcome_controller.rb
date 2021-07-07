class WelcomeController < ApplicationController
  def index
    @welcome = "Welcome Message"
    @description = "Description"
  end
end
