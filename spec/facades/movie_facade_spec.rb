require 'rails_helper'

describe 'MovieFacade' do
  it 'can facilitate movie title search' do
    response_body_1 = File.open("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results_pg_1.json")
    response_body_2 = File.open("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results_pg_2.json")

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api-key=5f797e906ade46b8521c83edea255f00&query=star%20wars")
         .with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.4.1'
           })
         .to_return(status: 200, body: response_body_1, headers: {})
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api-key=5f797e906ade46b8521c83edea255f00&page=2&query=star%20wars").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.4.1'
           }).
         to_return(status: 200, body: response_body_2, headers: {})

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
