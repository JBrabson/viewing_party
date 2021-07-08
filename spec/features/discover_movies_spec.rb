require 'rails_helper'

RSpec.describe 'discover movies' do
  describe 'allows an authenticated user' do
    before :each do
      @user = User.create(email: "test@app.com", name: "n4me", password: "passw0rd")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'click on discover movies and be taken to the discover movies page' do
      visit dashboard_path
      click_link 'Discover Movies'
      expect(current_path).to eq('/movies/discover')
    end
  end
end
