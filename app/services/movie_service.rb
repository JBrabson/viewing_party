class MovieService
  def self.search_movies_by_title(movie_title)
    response_1 = conn.get("/3/search/movie?query=#{movie_title}")
    response_1_json = JSON.parse(response_1.body, symbolize_names: true)
    response_2 = conn.get("/3/search/movie?query=#{movie_title}&page=2")
    response_2_json = JSON.parse(response_2.body, symbolize_names: true)
    response_1_json[:results] + response_2_json[:results]
  end

  private
  def self.conn()
    Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params['api-key'] = ENV['MOVIE_API_KEY']
    end
  end
end
