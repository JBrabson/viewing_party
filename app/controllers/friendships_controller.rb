class FriendshipsController < ApplicationController
  def create
    new_friend ||= User.find_by(email: friend_email)
    if new_friend.nil?
      flash[:error] = "#{friend_email} is not a partier"
    else
      current_user.friendships.create(friend_id: new_friend.id)
      flash[:success] = "#{new_friend.name} is now in your circle of trust"
    end
    redirect_to dashboard_path
  end

  private

  def friend_email
    params.permit(:friends_email)[:friends_email]
  end
end
