class UsersController < ApplicationController
  def show
    #binding.pry
    @user = User.find(session[:user_id])
  end
end
