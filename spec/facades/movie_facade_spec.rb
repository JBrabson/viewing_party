require 'rails_helper'

describe 'MovieFacade' do
  it 'can facilitate movie title search' do
    response_body_1 = File.open("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results_pg_1.json")
    response_body_2 = File.open("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results_pg_2.json")

    make_request(:get, "3/search/movie?api-key=#{ENV['MOVIE_API_KEY']}&query=star%20wars", response_body_1)
    make_request(:get, "3/search/movie?api-key=#{ENV['MOVIE_API_KEY']}&query=star%20wars&page=2", response_body_2)

    star_wars_search = MovieFacade.search_by_title('star wars')
    expect(star_wars_search).to be_an(Array)
    expect(star_wars_search.size).to eq(40)
    expect(star_wars_search.first).to be_an_instance_of(MoviePoro)
  end
  # it 'can facilitate top 40 movies query' do
  #   popular_movies = MovieFacade.top_40
  #   expect(popular_movies.count).to eq(40)
  # end
end
