class MovieService
  def self.search_movies_by_title(movie_title)
    response1 = conn.get("/3/search/movie?query=#{movie_title}")
    response1_json = JSON.parse(response1.body, symbolize_names: true)
    response2 = conn.get("/3/search/movie?query=#{movie_title}&page=2")
    response2_json = JSON.parse(response2.body, symbolize_names: true)
    response1_json[:results] + response2_json[:results]
  end

  def self.get_movie_details(type)
    response = conn.get("/3/movie/#{type}?")
    JSON.parse(response.body, symbolize_names: true)
  end

  # def self.get_cast(movie_id)
  #   response = conn.get("/3/movie/#{movie_id}/credits?")
  #   JSON.parse(response.body, symbolize_names: true)
  # end
  #
  # def self.get_reviews(movie_id)
  #   response = conn.get("/3/movie/#{movie_id}/reviews?")
  #   JSON.parse(response.body, symbolize_names: true)
  # end

  def self.top40
    response1 = conn.get('/3/movie/top_rated?')
    response1_json = JSON.parse(response1.body, symbolize_names: true)
    response2 = conn.get('/3/movie/top_rated?&page=2')
    response2_json = JSON.parse(response2.body, symbolize_names: true)
    response1_json[:results] + response2_json[:results]
  end

  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.params['api_key'] = ENV['MOVIE_API_KEY']
    end
  end

  private_class_method :conn
end
