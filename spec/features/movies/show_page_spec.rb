require 'rails_helper'

RSpec.describe 'movies show page' do
  it 'has a button to creat a viewing party' do
      @user = User.create!(email: 'test@app.com', name: 'n4me', password: 'passw0rd')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit discover_path
      search_term = 'star wars'

      response_body_1 = File.read("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results_pg_1.json")
      response_body_2 = File.read("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_search_results_pg_2.json")
      star_wars_details = JSON.parse(File.read("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_custom_details.json"), symbolize_names: true)
      require 'pry'; binding.pry
      make_request(:get, "3/search/movie?api-key=#{ENV['MOVIE_API_KEY']}&query=star%20wars", response_body_1)
      make_request(:get, "3/search/movie?api-key=#{ENV['MOVIE_API_KEY']}&query=star%20wars&page=2", response_body_2)


      fill_in :movie_title, with: search_term
      click_button 'Search Movies'
      click_link info_hash[:title].titleize
      expect(current_path).to eq(movies_show_path(first_search_term_result.id))
      expect(page).to have_content(first_search_term_result[:title])
      expect(page).to have_content(first_search_term_result[:vote_average])
      expect
  end
end
# Vote Average of the movie
# Runtime in hours & minutes
# Genere(s) associated to movie
# Summary description
# List the first 10 cast members (characters&actress/actors)
# Count of total reviews
# Each review's author and information
