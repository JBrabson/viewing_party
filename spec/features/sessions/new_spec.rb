require 'rails_helper'

RSpec.describe 'As a user' do
  before :each do
    visit registration_path
  end

  describe 'When I visit the Registration Page, it' do
    it 'displays welcome message' do
      expect(page).to have_content(@welcome_message)
    end

    it 'displays prompt to register for account' do
      expect(page).to have_content(@register_message)
    end

    it 'displays username field' do
      page.has_field?('Username', type: 'username')
    end

    it 'displays email field' do
      page.has_field?('Email', type: 'email')
    end

    it 'displays password field' do
      page.has_field?('Password', type: 'password')
    end

    it 'displays password confirmation field' do
      page.has_field?('Password Confirmation', type: 'password_confirmation')
    end

    it 'displays button to register' do
      expect(page).to have_button('Register')
    end
  end

  describe 'When I complete registration successfully, it' do
    it 'redirects to user dashboard' do
      fill_in 'user[username]', with: 'Movie Master'
      fill_in "user[email]", with: 'moviemaster@email.net'
      fill_in 'user[password]', with: 'password123'
      fill_in 'user[password_confirmation]', with: 'password123'

      click_button('Register')
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Welcome Movie Master!')
    end
  end

  #add tests for edgecase/fields blank
end
