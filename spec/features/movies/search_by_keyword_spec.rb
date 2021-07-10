require 'rails_helper'

feature 'search movies by keyword' do
  before :each do
    @user = User.create!(email: 'test@app.com', name: 'n4me', password: 'passw0rd')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit discover_path
  end
  it 'returns results' do
    star_wars = 'star wars'
    response_body = File.open("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results.json")
    stub_request(
      :get, "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIEDB_API_KEY']}&query=#{star_wars}&"
    ).to_return(
      status: 200, body: response_body
    )
    fill_in :movie_title, with: star_wars
    click_button 'Search Movies'
    expect(current_path).to eq(discover_path)
    expect(page).to have_content("Results for #{star_wars}:")
    within('#results') do
      response.body[:results].each do |result|
        expect(page).to have_link(result[:title])
        expect(page).to have_content("Vote Average: #{result[:vote_average]}")
      end
    end
  end
end
# TODO figure out how to take take the count of results (use #result css count)
# and make sure it is less than or equal to 40
