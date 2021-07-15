class PartiesController < ApplicationController

  def new
    @movie_title = params[:movie_title]
    @movie_runtime = params[:movie_runtime]
  end

  def create
    party = Party.new(params)
  end

end
