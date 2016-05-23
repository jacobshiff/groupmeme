class MembershipsController < ApplicationController

  def show
  end

  def destroy
    user = User.find_by(username: params[:username])
    membership = Membership.find_by(user: user, group: current_group)
    #binding.pry
    membership.destroy
    redirect_to edit_users_path(group_slug: current_group.group_slug)
  end

  def edit
    @user = User.find_by(username: params[:username])
    @membership = Membership.find_by(user: user, group: current_group)
    @type = params[:format]
  end

  def update
    # binding.pry
    user = User.find_by(username: params[:username])
    membership = Membership.find_by(user: user, group: current_group)
    membership.update(user_type: params[:format])
    redirect_to edit_users_path(group_slug: current_group.group_slug)
  end

end
