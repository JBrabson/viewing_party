require 'rails_helper'

RSpec.describe 'user dashboard' do
  before :each do
    user = User.create(email: 'test@app.com', name: 'n4me', password: 'passw0rd')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path
  end

  it 'has personalized welcome message' do
    expect(page).to have_content("Welcome #{@user.name}!")
  end

  # it 'has expected links' do
  #
  # end
end
