User.destroy_all

@user1 = User.create!(email: 'test@app.com', name: 'User 1', password: 'passw0rd')
@user2 = User.create!(email: 'friend@app.com', name: 'User 2', password: 'p4ssword')
@user3 = User.create!(email: 'friend2@app.com', name: 'User 3', password: 'p4ssword1')
@user4 = User.create!(email: 'friend3@app.com', name: 'User 4', password: 'p4ssword2')
@user1.friendships.create!(:friend_id => @user2.id)
@user1.friendships.create!(:friend_id => @user3.id)
@user1.friendships.create!(:friend_id => @user4.id)
