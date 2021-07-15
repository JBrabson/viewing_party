class MoviePoro
  attr_reader :title, :vote_average, :id, :runtime, :summary, :cast, :reviews

  def initialize(options = {})
    options[:search_hash] ||= {}
    options[:details_hash] ||= {}

    @title = options[:search_hash][:title] || options[:details_hash][:title]
    @vote_average = options[:search_hash][:vote_average]
    @id = options[:search_hash][:id] || options[:details_hash][:id]
    @runtime = options[:details_hash][:runtime] || nil
    @summary = options[:details_hash][:summary] || ""
    @cast = options[:cast_hash] || {}
    @reviews = options[:reviews] || {}
  end

  def formatted_runtime
    minutes = @runtime
    hours = minutes / 60
    remaining_minutes = minutes % 60
    "#{hours}:#{remaining_minutes}"
  end
end
