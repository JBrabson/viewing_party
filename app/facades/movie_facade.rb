class MovieFacade
  def self.search_by_title(movie_title)
    response = MovieService.search_movies_by_title(movie_title)
    response.map do |result|
      MoviePoro.new(result)
    end
  end

  def self.movie_details(movie_id)
    movie_details = MovieService.get_movie_details(movie_id)
    cast = MovieService.get_movie_details("#{movie_id}/credits")[:cast]
    reviews = MovieService.get_movie_details("#{movie_id}/reviews")[:results]

    first_ten_cast = cast.take(10).map do |actor_info|
      CastPoro.new(actor_info)
    end

    review_collection = reviews.map do |review_info|
      ReviewPoro.new(review_info)
    end

    MoviePoro.new(movie_details, first_ten_cast, review_collection)
  end

  def self.top40
    response = MovieService.top40
    response.map do |result|
      MoviePoro.new(result)
    end
  end
end
