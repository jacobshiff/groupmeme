class UsersController < ApplicationController

  def show
    @user = User.find_by(username: params[:username])
  end

  def edit
    @user = current_user
  end

  def update
  end

  def destroy
    current_user.destroy_memberships
    current_user.destroy
  end

  def update
  end

end
