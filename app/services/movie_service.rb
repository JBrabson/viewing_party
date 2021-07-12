class MovieService
  def self.search_movies_by_title(movie_title)
    response1 = conn.get("/3/search/movie?query=#{movie_title}")
    response1_json = JSON.parse(response1.body, symbolize_names: true)
    response2 = conn.get("/3/search/movie?query=#{movie_title}&page=2")
    response2_json = JSON.parse(response2.body, symbolize_names: true)
    response1_json[:results] + response2_json[:results]
  end

  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.params['api-key'] = ENV['MOVIE_API_KEY']
    end
  end
end
