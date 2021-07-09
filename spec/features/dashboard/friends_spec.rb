require 'rails_helper'

RSpec.describe 'user dashboard' do
  before :each do
    @user = User.create!(email: 'test@app.com', name: 'n4me', password: 'passw0rd')
    @friend = User.create!(email: 'friend@app.com', name: 'fr1end', password: 'p4ssword')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path
  end
  describe 'has a friends section' do
    # it 'has a header' do
    #   expect(page).to have_content('Your Friends')
    # end

    # it 'displays message when you have no friends' do
    #   within('#friends') do
    #     expect(page).to have_content('You currently have no friends.')
    #   end
    # end

    # it 'displays friends list if the user has friends' do
      # @user.friendships.create!(:friend_id => @friend.id)
      # within('#friends') do
        # expect(page).to have_content("#{@friend.name}")
      # end
    # end

    describe 'with a place to add friends'
      it 'has a place to add friends' do
        expect(page).to have_content()
      end
      it 'with a valid email' do

      end

      it 'but not with an invalid email' do

      end
  end
end
