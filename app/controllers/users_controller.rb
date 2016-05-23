class UsersController < ApplicationController
  def show
    #binding.pry
    @user = User.find(session[:user_id])
  end

  def edit
  end

  def update
  end

  def destroy
    @user.destroy 
  end
end
