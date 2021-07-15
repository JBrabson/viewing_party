class MoviePoro
  attr_reader :title, :vote_average, :id, :runtime, :summary, :cast, :reviews

  def initialize(options = {})
    options[:search_hash] ||= {}
    options[:details_hash] ||= {}

    @title = options[:search_hash][:title] || options[:details_hash][:title]
    @vote_average = options[:search_hash][:vote_average]
    @id = options[:search_hash][:id] || options[:details_hash][:id]
    @runtime = options[:details_hash][:runtime] || nil
    @genres_array = options[:details_hash][:genres] || []
    @summary = options[:details_hash][:summary] || ""
    @cast = options[:cast_hash] || {}
    @reviews = options[:reviews] || {}
  end

  def formatted_runtime
    hours = @runtime / 60
    minutes = @runtime % 60
    "#{hours}:#{minutes}"
  end

  def genres
    genres = []
    @genre_array.each do |genre_hash|
      genres << genre_hash[:name]
    end
    genres
  end
end
