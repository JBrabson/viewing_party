require 'rails_helper'

RSpec.describe MovieService do
  it 'can search moviedb by movie title' do
    search_term = "star wars"
    response = MovieService.search_movies_by_title(search_term)
    expect(response).to be_an(Array)
    expect(response.size).to eq(40)
    first_response = response.first
    expect(first_response).to have_key(:id)
    expect(first_response).to have_key(:title)
    expect(first_response).to have_key(:vote_average)
  end
end
