class UsersController < ApplicationController
  def show
    @user = User.find(session[:user_id])
  end

  def update
    binding.pry
  end
end
