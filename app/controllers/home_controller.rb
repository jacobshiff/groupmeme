class HomeController < ApplicationController

  def index
    if current_user
      if current_user.groups.count == 1
        binding.pry
        redirect_to(group_path(current_user.groups.first.group_slug))
      else
        redirect_to(groups_path)
      end
    else
      redirect_to 'http://itsgroupslam.com'
    end
  end

end
