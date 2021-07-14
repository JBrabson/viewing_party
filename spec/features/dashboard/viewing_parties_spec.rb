require 'rails_helper'

RSpec.describe "viewing parties" do
  before :each do
    @user = User.create!(email: 'test@app.com', name: 'n4me', password: 'passw0rd')
    @friend = User.create!(email: 'friend@app.com', name: 'fr1end', password: 'p4ssword')
    @invited = User.create!(email: 'invited@app.com', name: 'invited person', password: 'p4ssw0rd')

    @user.friendships.create!(friend_id: @friend.id)
    @user.friendships.create!(friend_id: @invited.id)
    @user_hosts_party = Party.create!(host_id: @user.id, movie_id: 11, start: 'july 20 2021, 16:00', end: 'july 20 2021, 18:00', movie_title: "Star Wars")
    @user_hosts_party.invitations.create!(invitee_id: @friend.id)
    @user_hosts_party.invitations.create!(invitee_id: @invited.id)

    @friend.friendships.create!(friend_id: @user.id)
    @friend.friendships.create!(friend_id: @invited.id)
    @friend_hosts_party = Party.create!(host_id: @friend.id, movie_id: 181812, start: 'july 25 2021, 17:00', end: 'july 25 2021, 19:00', movie_title: "Star Wars: The Rise of Skywalker")
    @friend_hosts_party.invitations.create!(invitee_id: @user.id)
    @friend_hosts_party.invitations.create!(invitee_id: @invited.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path
  end

  it 'shows parties I am invited to on the dashboard' do
    within('#parties') do
      within('#attending') do
        expect(page).to have_content("Attending")
        expect(page).to have_link(@friend_hosts_party.movie_title)
        expect(page).to have_content(@friend_hosts_party.start.strftime("%D"))
        expect(page).to have_content(@friend_hosts_party.start.strftime("%l:%M %P"))
        expect(page).to have_content("Hosted by: #{@friend.name}")
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@invited.name)
      end
      # TODO test if users name is bold
    end
  end

  it 'shows parties I have created on the dashboard' do
    within('#parties') do
      within('#hosting') do
        expect(page).to have_content("Hosting")
        expect(page).to have_link(@user_hosts_party.movie_title)
        expect(page).to have_content(@user_hosts_party.start.strftime("%D"))
        expect(page).to have_content(@user_hosts_party.start.strftime("%l:%M %P"))
        expect(page).to have_content(@friend.name)
        expect(page).to have_content(@invited.name)
      end
    end
  end
  # TODO sad path for no invited parties
  # TODO sad path for no created parties
  # TODO sad path for no guests invited to your party?
  # TODO facade for partyinfo poro? could then make all parties into poros with correct info and send to view to be displayed by date
end
