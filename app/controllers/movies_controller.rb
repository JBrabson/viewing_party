class MoviesController < ApplicationController
  def index
    if params[:movie_title].present?
      MovieFacade.search_by_title(params[:movie_title])
    else
      MovieFacade.top_40
    end
    redirect_to discover_path
  end
end
