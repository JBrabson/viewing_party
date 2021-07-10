class MoviesController < ApplicationController
  def index
    redirect_to discover_path
  end
end
