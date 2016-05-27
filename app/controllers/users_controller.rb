class UsersController < ApplicationController

  def show
    @user = User.find_by(username: params[:username])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.avatar = params[:user][:avatar]
    @user.avatar.reprocess!
    # @user.avatar.save
    # @user.save
    # @user.update(user_params)
    redirect_to user_path(@user.username)
  end

  def destroy
    current_user.destroy_memberships
    current_user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end

end
