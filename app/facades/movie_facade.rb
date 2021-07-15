class MovieFacade
  def self.search_by_title(movie_title)
    response = MovieService.search_movies_by_title(movie_title)
    response.map do |result|
      MoviePoro.new(search_hash: result)
    end
  end

  def self.movie_details(movie_id)
    movie_details = MovieService.get_movie_details(movie_id)
    # cast = MovieService.get_movie_details("#{movie_id}/credits")
    # reviews = MovieService.get_movie_details("#{movie_id}/reviews")
    # MoviePoro.new(details_hash: movie_details, cast_hash: cast, reviews_hash: reviews)

    first_ten_cast = cast.take(10).map do |actor_info|
      CastPoro.new(actor_info)
    end

    review_collection = reviews.map do |review|
      ReviewPoro.new(review_info)
    end
    
    MoviePoro.new(details_hash: movie_details, cast: first_ten_cast, reviews: review_collection)
  end

  def self.top40
    response = MovieService.top40
    response.map do |result|
      MoviePoro.new(popular_hash: result)
    end
  end
end
