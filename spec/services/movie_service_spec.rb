require 'rails_helper'

RSpec.describe MovieService do
  it 'can search moviedb by movie title' do
    search_term = "star wars"
    response_body_1 = File.open("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results_pg_1.json")

    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api-key=#{ENV['MOVIE_API_KEY']}&query=star%20wars")
         .with(
           headers: {
       	  'User-Agent'=>'Faraday v1.4.1'
           })
         .to_return(status: 200, body: response_body_1, headers: {})
    response_body_2 = File.open("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results_pg_2.json")
    stub_request(:get, "https://api.themoviedb.org/3/search/movie?api-key=#{ENV['MOVIE_API_KEY']}&page=2&query=star%20wars").
         with(
           headers: {
       	  'User-Agent'=>'Faraday v1.4.1'
           })
         .to_return(status: 200, body: response_body_2, headers: {})
    response = MovieService.search_movies_by_title(search_term)
    expect(response).to be_an(Array)
    expect(response.size).to eq(40)
    first_response = response.first
    expect(first_response).to be_a(Hash)
    expect(first_response).to have_key(:id)
    expect(first_response).to have_key(:title)
    expect(first_response).to have_key(:vote_average)
  end
end
