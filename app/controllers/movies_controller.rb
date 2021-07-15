class MoviesController < ApplicationController
  def index
    if params[:movie_title].present?
      @search_results = MovieFacade.search_by_title(params[:movie_title])
    else
      @top40 = MovieFacade.top40
    end
  end
end
