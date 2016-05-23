class MembershipsController < ApplicationController

  def show
  end

  def destroy
    user = User.find_by(username: params[:username])
    membership = Membership.find_by(user: user, group: current_group)
    #binding.pry
    membership.destroy
    redirect_to edit_users_path(current_group)
  end

end
