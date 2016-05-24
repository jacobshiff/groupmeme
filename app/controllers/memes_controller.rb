require 'open-uri'

require 'meme_captain'

class MemesController < ApplicationController
    before_action :set_group, only: [:index, :new]
    before_action :set_meme, only: [:show, :destroy, :react]
    before_action :require_login_and_access

  def index
    # group_slug = params[:group_slug]
    # @group = Group.find_by(group_slug: group_slug)
    @memes = Meme.where(group: @group)

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
    #potential optimization to limit set_meme calls?
  end

  def new
    @meme = Meme.new
  end

  def create
    @meme = Meme.new(meme_params)
    @meme.group = Group.find_by(group_slug: params[:group_slug])
    @meme.creator = current_user
    if @meme.save
      redirect_to meme_path(group_slug: @meme.group.group_slug, id: @meme.id)
    else
      render :new
    end
  end

  def destroy
    @meme.destroy
    redirect_to memes_path(@meme.group.group_slug)
  end

  def react
    @meme.update_reactions(current_user)
    @current_user = current_user

    respond_to do |format|
      format.js
    end
  end

  def maker
    @meme = Meme.new
    #do the whole form thing and collect params vars, THEEEEEEEN goto maker2
    render :maker2
  end

  def maker2
    # open('http://memesvault.com/wp-content/uploads/Angry-Meme-02.jpg', 'rb') do |f|

    if(params[:url_path])               #if theres a url path saved,
      open(params[:url_path]) do |f|    #attempt to open it and...
        # binding.pry
        i = MemeCaptain.meme_top_bottom(f, txt_top, txt_bottom)
        i.write('output.jpg')  #change to a preview solution, then if ok, write to heroku-style thing
      end
    else
      puts "////////////////DIDNT GET A URL////////////////"
    end
  end




  private
  def set_meme
    @meme ||= Meme.find(params[:id])
  end

  def set_group
    @group = Group.find_by(group_slug: params[:group_slug])
  end

  def meme_params
    params.require(:meme).permit(:image, :title)
  end

end
