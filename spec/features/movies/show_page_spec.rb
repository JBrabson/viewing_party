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
    make_request(:get, "3/search/movie?api-key=#{ENV['MOVIE_API_KEY']}&query=star%20wars", response_body_1)
    make_request(:get, "3/search/movie?api-key=#{ENV['MOVIE_API_KEY']}&query=star%20wars&page=2", response_body_2)

    #
    fill_in :movie_title, with: search_term
    click_button 'Search Movies'
    click_link star_wars_details[:title].titleize
    expect(current_path).to eq(movies_show_path(star_wars_details[:id]))
    expect(page).to have_content(star_wars_details[:title])
    expect(page).to have_content(star_wars_details[:vote_average])

    # TODO  runtime in hours and minutes
    # expect(page).to have_content(star_wars_details[:vote_average])

    # genre
    star_wars_details[:genres].each do |genre|
      expect(page).to have_content(genre)
    end

    # summary
    expect(page).to have_content(star_wars_details[:summary])

    # actor and character
    star_wars_details[:cast_members].each do |cast_member|
      expect(page).to have_content(cast_member[:name])
      expect(page).to have_content(cast_member[:character])
    end

    # total count of reviews
    expect(page).to have_content(star_wars_details[:reviews].count)

    # author and info
    star_wars_details[:reviews].each do |review|
      expect(page).to have_content(review[:author])
      expect(page).to have_content(review[:content])
    end
  end
end
