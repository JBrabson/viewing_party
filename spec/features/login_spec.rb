require 'rails_helper'

RSpec.describe 'logging in' do
  it 'allows a user to log it with the correct info' do
    user = User.create(name: "Test", password: "Test", email: "test@app.com")

    visit root_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_button  "Login"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Welcome back, #{user.name}")
    expect(page).to have_link("Log Out")
    expect(page).to_not have_link("Ready to Join the Party? Register Here")
  end

  it 'does not allow a user to log in with incorrect info' do
    user = User.create(name: "Test", password: "Test", email: "test@app.com")

    visit root_path

    fill_in :email, with: user.email
    fill_in :password, with: "badpass"

    click_button  "Login"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Your credentials are invalid, please try again")
  end
end
