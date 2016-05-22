class HomeController < ApplicationController

  def index
    groups = Group.all
    @groups = groups.reject{ |g| g.group_slug.nil? }
  end

end
