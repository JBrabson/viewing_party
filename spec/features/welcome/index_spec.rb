require 'rails_helper'

RSpec.describe 'Welcome Page' do
    it 'displays welcome message and app description' do
      visit '/'
      expect(page).to have_content(@welcome_message)
      expect(page).to have_content(@description)
      expect(page).to have_button("Login")
      expect(page).to have_link("Register")
    end
end
