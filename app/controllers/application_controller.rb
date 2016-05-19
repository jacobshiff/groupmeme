class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in?
    session[:user_id] != nil
  end

  def access_to_group?
    set_user if logged_in?
    @user.groups.include?(Group.find_by(group_slug: params[:group_slug]))
  end

  def require_login_and_access
    if !logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path(params[:group_slug])
    else
      require_access
    end
  end

  def require_access
    if !access_to_group?
      flash[:danger] = "You do not have access to this page."
      redirect_to login_path(params[:group_slug])
    end
  end

  def set_user
    @user = User.find(session[:user_id])
  end

end
