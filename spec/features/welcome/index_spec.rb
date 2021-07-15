require 'rails_helper'

RSpec.describe 'Welcome Page' do
  before :each do
    visit root_path
  end

  it 'displays welcome message' do
    welcome_message = 'Welcome to the (View)Party'
    expect(page).to have_content(welcome_message)
  end

  it 'displays application description' do
    description = 'WHERE YOU CAN BRING THE MOVIE TO THE PARTY OR THE PARTY TO THE MOVIE'
    expect(page).to have_content(description)
  end

  it 'displays login fields for email and password' do
    expect(page).to have_field('email', type: 'text')
    expect(page).to have_field('password', type: 'password')
  end

  it 'displays button to log in' do
    expect(page).to have_button("Login")
  end

  it 'displays link to register' do
    expect(page).to have_link("Ready to Join the Party? Register Here")
  end
end
