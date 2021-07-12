class MoviePoro
  attr_reader :title, :vote_average, :id

  def initialize(info_hash)
    @title = info_hash[:title]
    @vote_average = info_hash[:vote_average]
    @id = info_hash[:id]
  end
end
