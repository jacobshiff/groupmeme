class UsersController < ApplicationController
  def show
    @user = User.find(session[:user_id])
  end

  def edit
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
