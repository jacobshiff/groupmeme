class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] #this might make things weird because it no longer returns current_user as nil -- if any other methods rely on that, try changing this
  end

  ####Return to confirm that 'cheap man's caching' doesn't cause any bugs!
  helper_method def current_group
    @current_group ||= Group.find_by(group_slug: params[:group_slug]) if params[:group_slug]
  end

  helper_method def format_time(time)
    # Changed default timezone to ET in config: "config.time_zone = 'Eastern Time (US & Canada)'"
    if time.strftime("%Y-%m-%d") == Time.now.in_time_zone.strftime("%Y-%m-%d")
      "today at #{time.strftime("%I:%M %p")}"
    else
      time.strftime("%I:%M %p on %b %d, %Y")
    end
  end

  def logged_in?
    session[:user_id] != nil
  end

  def access_to_group?
    set_user if logged_in?
    @user.groups.include?(current_group)
  end

  def require_login_and_access
    if !logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_path
    else
      require_access
    end
  end

  def require_access
    if !access_to_group?
      flash[:danger] = "You do not have access to this page."
      redirect_to groups_path
    end
  end

  def set_user
    @user ||= User.find(session[:user_id])
  end
end
