require 'rails_helper'

feature 'search movies by keyword' do
  before :each do
    @user = User.create!(email: 'test@app.com', name: 'n4me', password: 'passw0rd')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit discover_path
  end

  it 'returns results' do
    search_term = 'star wars'
    response_body_1 = File.read("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results_pg_1.json")
    response_body_2 = File.read("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results_pg_2.json")
    response_1_json = JSON.parse(response_body_1, symbolize_names: true)
    response_2_json = JSON.parse(response_body_2, symbolize_names: true)
    response = response_1_json[:results] + response_2_json[:results]

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
    fill_in :movie_title, with: search_term
    click_button 'Search Movies'
    expect(current_path).to eq(movies_index_path)
    # TODO does this match the wireframe?
    expect(page).to have_content("Results for #{search_term.titleize}:")
    within('#results') do
      response.each do |result|
        expect(page).to have_link(result[:title])
        expect(page).to have_content("Vote Average: #{result[:vote_average]}")
      end
      # do something like expect(response.body[:results].count).to eq((css #result).count )
      # figure out how to do 40 of them at some point
    end
  end
end
# TODO make a helper method for lines 11-30 since they are called in multiple spec files
# TODO make a helper method for lines 5-6
