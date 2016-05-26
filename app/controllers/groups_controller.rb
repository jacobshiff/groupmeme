class GroupsController < ApplicationController
  before_action :current_user
  before_action :set_group, only: [:show, :destroy, :edit, :update]
  #before_action :require_login_and_access

  def index
    @groups = current_user.groups
  end

  def show
    redirect_to memes_path(@group.group_slug)
    #@group = Group.find_by(group_slug: params[:group_slug])
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
  end

  def update
    @group.update(group_params)
    redirect_to group_path(@group.group_slug)
  end

  def destroy
    if current_user.type(@group) == "admin"
      @group.destroy
      redirect_to groups_path
    else
      flash[:danger] = "You do not have permissions to do that."
    end
  end

  def edit_users
    @users = current_group.users
  end

  def user_index
    @users = current_group.users
  end

  private

  def group_params
    params.require(:group).permit(:title, :image)
  end

  def set_group
    @group = Group.find_by(group_slug: params[:group_slug])
  end

end
