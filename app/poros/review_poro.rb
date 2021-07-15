class ReviewPoro
  attr_reader :content, :author

  def initialize(raw_response)
    @content = raw_response[:content]
    @author = raw_response[:author]
  end
end
