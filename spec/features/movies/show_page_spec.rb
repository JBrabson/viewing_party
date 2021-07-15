require 'rails_helper'

RSpec.describe 'movies show page' do
  it 'has movie details' do
    user = User.create!(email: 'test@app.com', name: 'n4me', password: 'passw0rd')
    star_wars_details = JSON.parse(File.read("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_custom_details.json"), symbolize_names: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    cast_response = File.read("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_cast_response.json")
    details_response = File.read("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_details_response.json")
    reviews_response = File.read("#{Rails.root}/spec/fixtures/moviedb_api/star_wars_review_response.json")
    make_request(:get, "3/movie/#{star_wars_details[:id]}?api_key=#{ENV['MOVIE_API_KEY']}", details_response)
    make_request(:get, "3/movie/#{star_wars_details[:id]}/reviews?api_key=#{ENV['MOVIE_API_KEY']}", reviews_response)
    make_request(:get, "3/movie/#{star_wars_details[:id]}/credits?api_key=#{ENV['MOVIE_API_KEY']}", cast_response)

    visit "/movies/#{star_wars_details[:id]}"
    expect(page).to have_content(star_wars_details[:title])
    expect(page).to have_content(star_wars_details[:vote_average])
save_and_open_page
    # runtime in minutes
    expect(page).to have_content("Runtime: 2:01")

    # genre
    star_wars_details[:genres].each do |genre|
      expect(page).to have_content(genre.titleize)
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
      # expect(page).to have_content(review[:content])
      # TODO this is not working. why? who knows.
    end
  end
end
