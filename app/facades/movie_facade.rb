class MovieFacade
  def self.search_by_title(movie_title)
    response = MovieService.search_movies_by_title(movie_title)
    response.map do |result|
      MoviePoro.new(search_hash: result)
    end
  end

  def self.movie_details(movie_id)
    movie_details = MovieService.get_movie_details(movie_id)
    cast = MovieService.get_cast("#{movie_id}/credits")
    reviews = MovieService.get_reviews("#{movie_id}/reviews")
    MoviePoro.new(details_hash: movie_details, cast_hash: cast, reviews_hash: reviews)
  end
end
