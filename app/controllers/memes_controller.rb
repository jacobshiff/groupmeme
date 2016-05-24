class MemesController < ApplicationController
    before_action :set_meme, only: [:show, :destroy, :react]
    before_action :require_login_and_access

  def index
    # group_slug = params[:group_slug]
    # @group = Group.find_by(group_slug: group_slug)
    @memes = Meme.where(group: current_group)
    @group = current_group

    #Toodoo: REFACTOR ME INTO HELPER METHOD FOR SORTING TYPE CHOOSER
    #params[:sort]  #viral, or time, or rising   /memes/by/[x]

    if params[:sort]   #how do we wish to mutate-sort our localvar, @memes?
      #if it exists
      case (params[:sort])
      when "viral"
        #sort virally
        @memes = @memes.sort_by {|meme| - meme.reactions.count}
      when "newest"
        #sort chrono
        @memes = @memes.sort_by(&:created_at).reverse
      when "oldest"
        @memes = @memes.sort_by(&:created_at)
      when "rising"
        #sort rising
        @memes = @memes.sort_by {|meme| - meme.reactions.where(created_at: (Time.now - 1.hour)..Time.now).count}
      else
        flash[:warning] = "What exactly are you trying to do here, pal?"
      end
    end
  end

  def show
  end

  def new
    @meme = Meme.new
  end

  def create
    #binding.pry

    @meme = Meme.new(meme_params)
    @meme.group = current_group
    @meme.creator = current_user
    if @meme.save
    	render json: { message: "success" }, :status => 200
    else
      render json: { error: @meme.errors.full_messages.join(',')}, :status => 400
    end
  end

  def destroy
    @meme.destroy
    redirect_to memes_path(current_group.group_slug)
  end

  def react
    @meme.update_reactions(current_user)
    @current_user = current_user

    respond_to do |format|
      format.js
    end
  end

  private
  def set_meme
    @meme ||= Meme.find(params[:id])
  end

  def meme_params
    params.require(:meme).permit(:image, :title)
  end

end
