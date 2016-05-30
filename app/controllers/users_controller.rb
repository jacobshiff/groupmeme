class UsersController < ApplicationController

  def show
    if_confirmed_user_permission{ #confirm that the user has the right permission...
      @user = current_user
    }
  end

  def update
    if_confirmed_user_permission{
      @user = current_user
      @user.avatar = params[:user][:avatar]
      @user.avatar.reprocess!
      # @user.avatar.save
      # @user.save
      # @user.update(user_params)
      redirect_to user_path(@user.username)
    }
  end

  def destroy
    if_confirmed_user_permission{
      current_user.destroy_memberships
      current_user.destroy
    }
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end

  def if_confirmed_user_permission
    if current_user.username == params[:username] #check that user from session id is same as user from params (i.e. user they are trying to edit)
      yield
    else
      flash[:danger] = "You do not have permission edit this user"
      redirect_to user_path(current_user.username)
    end
  end

end
