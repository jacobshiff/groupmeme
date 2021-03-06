class GroupsController < ApplicationController
  before_action :current_user

  def index
    @groups = current_user.groups
  end

  def show
    redirect_to memes_path(current_group.group_slug)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.group_slug = @group.to_slug
    @group.group_creator = current_user
    @group.save
    Membership.create(group: @group, user: current_user, user_type: "admin")
    redirect_to group_path(@group.group_slug)
  end

  def edit
    confirmed_admin_status?{
      set_group
    }
  end

  def update
    confirmed_admin_status?{
      set_group
      @group.update(group_params)
      if group_params[:title]
        @group.group_slug = @group.to_slug
        @group.save
      end
      redirect_to group_path(@group.group_slug)
    }
  end

  def destroy
    confirmed_admin_status?{
      current_group.destroy
      redirect_to groups_path
    }
    # if current_user.type(@group) == "admin"
    #   @group.destroy
    #   redirect_to groups_path
    # else
    #   flash[:danger] = "You do not have permissions to do that."
    # end
  end

  def edit_users
    confirmed_admin_status?{
      @users = current_group.users
    }
  end

  def user_index
    confirmed_admin_status?{
      @users = current_group.users
    }
  end

  private

  def group_params
    params.require(:group).permit(:title, :image)
  end

  def set_group
    @group = Group.find_by(group_slug: params[:group_slug])
  end

  def confirmed_admin_status?
    if current_user.type(current_group) == "admin"
      yield
    else
      flash[:danger] = "You do not have permission to perform this action."
      redirect_to groups_path
    end
  end

end
