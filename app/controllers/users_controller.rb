class UsersController < ApplicationController

  def show
    @user = User.find_by(username: params[:username])
  end

  def edit
  end

  def destroy
    current_user.destroy_memberships
    current_user.destroy
  end

  def update
    # binding.pry
    @user = User.find_by(username: params[:username])
    @user.update(user_params)


    # @user.avatar = user_params[:avatar]
    # @user.avatar.save

    redirect_to user_path(@user.username)
  end

  private

  def user_params
    params.require(:user).permit(:username,:avatar)
  end

end


avatar = user_params[:avatar]
@user.avatar = avatar
@user.avatar.url
@user.save


@user.avatar
@user.avatar.url
@user.save
@user.avatar.image
@user.avatar.url
@user.avatar.save
