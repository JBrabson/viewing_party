class MoviePoro
  attr_reader :title, :vote_average, :id, :runtime, :summary, :cast, :reviews

  def initialize(options = {})
    options[:search_hash] ||= {}
    options[:details_hash] ||= {}
    options[:cast_hash] ||= {}
    options[:reviews_hash] ||= {}
    options[:popular_hash] ||= {}


    @title = options[:search_hash][:title] || options[:details_hash][:title] || options[:popular_hash][:title]
    @vote_average = options[:search_hash][:vote_average] || options[:details_hash][:vote_average] || options[:popular_hash][:vote_average]
    @id = options[:search_hash][:id] || options[:details_hash][:id] || options[:popular_hash][:id]
    @runtime = options[:details_hash][:runtime] || nil
    @genres_array = options[:details_hash][:genres] || []
    @summary = options[:details_hash][:overview] || ""
    @cast = options[:cast_hash][:cast] || {}
    @reviews = options[:reviews_hash][:results] || {}
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
