class MoviePoro
  attr_reader :title, :vote_average, :id, :runtime, :summary, :cast, :reviews

  def initialize(info, cast = [], reviews = [])
    @id = info[:id]
    @title = info[:title]
    @vote_average = info[:vote_average]
    @runtime = info[:runtime]
    @genres_array = info[:genres]
    @summary = info[:overview]
    @cast = cast
    @reviews = reviews
  end

  def formatted_runtime
    hours = @runtime / 60
    minutes = @runtime % 60
    "#{hours}:#{format('%02d', minutes)}"
  end

  def genres
    genres = []
    @genres_array.each do |genre_hash|
      genres << genre_hash[:name]
    end
    genres
  end
end
