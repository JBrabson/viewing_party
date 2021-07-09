require 'rails_helper'

RSpec.describe 'user dashboard' do
  before :each do
    @user = User.create!(email: 'test@app.com', name: 'n4me', password: 'passw0rd')
    @friend = User.create!(email: 'friend@app.com', name: 'fr1end', password: 'p4ssword')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path
  end

  # it 'has personalized welcome message' do
  #   expect(page).to have_content("Welcome #{@user.name}!")
  # end
  #
  # it 'has expected link to discover movies' do
  #   expect(page).to have_link('Discover Movies')
  # end

  describe 'has a friends section' do
    # it 'has a header' do
    #   expect(page).to have_content('Your Friends')
    # end

    # it 'displays message when you have no friends' do
    #   within('#friends') do
    #     expect(page).to have_content('You currently have no friends.')
    #   end
    # end

    it 'displays friends list if the user has friends' do
      @user.friendships.create!(:friend_id => @friend.id)
      require 'pry';binding.pry

      # Friendship.create!(user_id: @user.id, friend_id: @friend.id)
      within('#friends') do
        expect(page).to have_content("#{@friend.name}")
      end
    end

    # describe 'with a place to add friends'
    #   it 'with a valid email' do
    #
    #   end
    #
    #   it 'but not with an invalid email' do
    #
    #   end
  end

  it 'has a viewing parties section' do
    expect(page).to have_content('Your Viewing Parties')
  end
end
