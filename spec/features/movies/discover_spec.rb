require 'rails_helper'

RSpec.describe 'movie discover page' do
  before :each do
    @user = User.create!(email: 'test@app.com', name: 'n4me', password: 'passw0rd')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit discover_path
  end

  it 'has a button to find top rated movies' do
    expect(page).to have_button('Find Top Rated Movies')
  end

  it 'has a place to put a movie title and button to search' do
    expect(page).to have_field(:movie_title)
    expect(page).to have_button("Search Movies")
  end
end
