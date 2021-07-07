require 'rails_helper'

RSpec.describe 'Welcome Page' do
    it 'displays welcome message' do
      visit '/'
      expect(page).to have_content(@welcome_message)
    end

    it 'displays application description' do
      visit '/'
      expect(page).to have_content(@description)
    end

    it 'displays login fields for username and password' do
      visit '/'
      page.has_field?('Username', type: 'username')
      page.has_field?('Password', type: 'password')
    end

    it 'displays button to log in' do
      visit '/'
      expect(page).to have_button("Login")
    end

    it 'displays link to register' do
      visit '/'
      expect(page).to have_link("Ready to Join the Party? Register Here")

      click_link("Ready to Join the Party? Register Here")
      expect(current_path).to eq(registration_path)
    end
end
