require 'rails_helper'

RSpec.describe 'As a user' do
  before :each do
    visit registration_path
  end

  describe 'When I visit the Registration Page, it' do
    it 'displays welcome message' do
      save_and_open_page
      expect(page).to have_content('Register Below to Become a V.I.P. of VP!')
    end

    it 'displays prompt to register for account' do
      expect(page).to have_content('FILL OUT THE BELOW TO GET THIS PARTY STARTED')
    end

    it 'displays email field' do
      expect(page).to have_field('user[email]')
    end

    it 'displays password field' do
      expect(page).to have_field('user[password]')
    end

    it 'displays password confirmation field' do
      expect(page).to have_field('user[password_confirmation]')
    end

    it 'displays button to register' do
      expect(page).to have_button('Register')
    end
  end

  describe 'When I complete registration successfully, it' do
    it 'redirects to user dashboard' do
      fill_in 'user[email]', with: 'moviemaster@email.net'
      fill_in 'user[password]', with: 'password123'
      fill_in 'user[password_confirmation]', with: 'password123'

      click_button('Register')
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Welcome moviemaster@email.net!')
    end
  end

  #add tests for edgecase/fields blank
end
