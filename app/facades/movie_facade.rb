class MovieFacade
  def self.search_by_title(movie_title)
    response = MovieService.search_movies_by_title(movie_title)
    @results = response[:results].map do |result|
      MoviePoro.new(result)
    end
  end
end
