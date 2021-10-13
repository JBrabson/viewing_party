require 'rails_helper'

RSpec.describe MoviePoro do
  it 'instantiates with expected attributes' do
    star_wars_json = File.read("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results_pg_1.json")
    single_search_result = JSON.parse(star_wars_json, symbolize_names: true)[:results].first
    movie_poro = MoviePoro.new(single_search_result)
    expect(movie_poro.title).to be_a(String)
    expect(movie_poro.title).to eq("Star Wars")
    expect(movie_poro.vote_average).to be_a(Float)
    expect(movie_poro.vote_average).to eq(8.2)
    expect(movie_poro.id).to be_a(Integer)
    expect(movie_poro.id).to eq(11)
  end
end
