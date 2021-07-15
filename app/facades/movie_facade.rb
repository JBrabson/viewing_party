class MovieFacade
  def self.search_by_title(movie_title)
    response = MovieService.search_movies_by_title(movie_title)
    response.map do |result|
      MoviePoro.new(result)
    end
  end

  def self.top40
    response = MovieService.top40
    response.map do |result|
      MoviePoro.new(result)
    end
  end
end
