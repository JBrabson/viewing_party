require 'rails_helper'

RSpec.describe 'user dashboard' do
  before :each do
    @user = User.create!(email: 'test@app.com', name: 'n4me', password: 'passw0rd')
    @friend = User.create!(email: 'friend@app.com', name: 'fr1end', password: 'p4ssword')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit '/dashboard'
  end
  
  describe 'has a friends section' do
    it 'has a header' do
      expect(page).to have_content('Your Friends')
    end

    it 'displays message when you have no friends' do
      within('#friends') do
        expect(page).to have_content('You currently have no friends.')
      end
    end

    it 'displays friends list if the user has friends' do
      @user.friendships.create!(:friend_id => @friend.id)
      refresh
      within('#friends') do
        expect(page).to have_content("#{@friend.name}")
      end
    end

    describe 'with a place to add friends'
      it 'has a place to add friends' do
        expect(page).to have_field(:friends_email)
        expect(page).to have_button("Add Friend")
      end

      it 'with a valid email' do
        fill_in :friends_email, with: @friend.email
        click_button "Add Friend"

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("#{@friend.name} is now in your circle of trust")

        within('#friends') do
          expect(page).to have_content("#{@friend.name}")
        end
      end

      it 'but not with an invalid email' do
        dumb_email = 'pickles@nope.yo'

        fill_in :friends_email, with: dumb_email
        click_button "Add Friend"

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("#{dumb_email} is not a partier")

        within('#friends') do
          expect(page).to have_content('You currently have no friends.')
        end
      end
  end
end
