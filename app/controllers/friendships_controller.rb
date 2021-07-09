class FriendshipsController < ApplicationController
  def create
    if user_email?(friend_email)
        # make user_email? method
        # make friendship using the associated id of the friend_email and current_user.id
        flash[:success] = "#{NAME OF NEW FRIEND}is now in your circle of trust"
        redirect_to dashboard_path
      else
        flash[:error] = "#{friend_params} is not a partier"
        redirect_to dashboard_path
    end
  end

  private

  def friend_email
    params.permit(:friends_email)
end
