class CastPoro
  attr_reader :character, :name

  def initialize(raw_response)
    @character = raw_response[:character]
    @name = raw_response[:name]
  end
end
