require 'rails_helper'

RSpec.describe 'As a user' do
  before :each do
    visit registration_path
  end

  describe 'When I visit the Registration Page, it' do
    it 'displays welcome message' do
      expect(page).to have_content('Register Below to Become a V.I.P. of VP!')
    end

    it 'displays prompt to register for account' do
      expect(page).to have_content('FILL OUT THE BELOW TO GET THIS PARTY STARTED')
    end

    it 'displays name field' do
      expect(page).to have_field('user[name]')
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
      user = {name: 'Movie Master', email: 'moviemaster@email.net',
      password: 'password123'}

      fill_in 'user[name]', with: user[:name]
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      fill_in 'user[password_confirmation]', with: user[:password]
      click_button('Register')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome #{user[:name]}")
    end
  end

  describe 'When passwords do not match, it' do
    it 'redirects to new registration with error message' do
      user = {name: 'Movie Master', email: 'moviemaster@email.net',
      password: 'password123', password_confirmation: 'password'}

      fill_in 'user[name]', with: user[:name]
      fill_in 'user[email]', with: user[:email]
      fill_in 'user[password]', with: user[:password]
      fill_in 'user[password_confirmation]', with: user[:password_confirmation]
      click_button('Register')
      expect(current_path).to eq(registration_path)
      expect(page).to have_content('Password and confirmation must match. Please try again.')
    end
  end
  #TODO add tests for edgecase/fields blank and flash messages
end
