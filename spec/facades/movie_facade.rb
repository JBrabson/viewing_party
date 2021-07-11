require 'rails_helper'

describe 'MovieFacade' do
  it 'can facilitate movie title search' do
    star_wars_search = MovieFacade.search_by_title('star wars')
      expect(star_wars_search).to be_an(Array)
      expect(star_wars_search.size).to eq(40)
      expect(star_wars_search.first).to be_an_instance_of_a(MoviePoro)
  end
  # it 'can facilitate top 40 movies query' do
  #   popular_movies = MovieFacade.top_40
  #   expect(popular_movies.count).to eq(40)
  # end
end
