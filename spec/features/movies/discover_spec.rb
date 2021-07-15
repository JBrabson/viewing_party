require 'rails_helper'

RSpec.describe 'movie discover page' do
  before :each do
    @user = User.create!(email: 'test@app.com', name: 'n4me', password: 'passw0rd')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit discover_path
  end

  describe 'Top Rated Movies section' do
    before :each do
      page1 = File.read("#{Rails.root}/spec/fixtures/moviedb_api/top_40_results_pg_1.json")
      page2 = File.read("#{Rails.root}/spec/fixtures/moviedb_api/top_40_results_pg_2.json")
      page_1_json = JSON.parse(page1, symbolize_names: true)
      page_2_json = JSON.parse(page2, symbolize_names: true)
      response = page_1_json[:results] + page_2_json[:results]

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}").
           with(
             headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.4.1'
             }).
           to_return(status: 200, body: page1, headers: {})

       stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=2").
            with(
              headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v1.4.1'
              }).
            to_return(status: 200, body: page2, headers: {})
    end

    it 'has a button to find top rated movies' do
      expect(page).to have_button('Find Top Rated Movies')
      click_button('Find Top Rated Movies')
      expect(current_path).to eq(movies_index_path)
      expect(page).to have_button('Find Top Rated Movies')
      within ("#top40") do
        expect(page).to have_content(@top40)
        expect(page).to have_css('li', count: 40)
      end
    end

    it 'displays each movie title as link to movie show page' do
      click_button('Find Top Rated Movies')
      within ("#top40") do
        expect(page).to have_link(count: 40)
        #TODO test for route to show page
      end
    end
  end

  it 'has a place to put a movie title and button to search' do
    expect(page).to have_field(:movie_title)
    expect(page).to have_button("Search Movies")
  end
end
