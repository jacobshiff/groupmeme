class HomeController < ApplicationController

  def index

    if current_user   #if logged in already
      if current_user.groups.count == 1
        redirect_to(group_path(current_user.groups.first.group_slug))
      else
        redirect_to(groups_path)
      end

    else #if NOT logged in
      # render :layout => false
      render layout: false
      render file: "/vendor/index.html"
    end

  end #index








end #HomeController