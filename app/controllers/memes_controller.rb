require 'open-uri'

require 'meme_captain'

class MemesController < ApplicationController
    before_action :set_group, only: [:index, :new]
    before_action :set_meme, only: [:show, :destroy, :react]
    before_action :require_login_and_access

  def index
    @memes = Meme.where(group: @current_group).order(id: :desc)
    # @memes = Meme.where(group: @current_group).last(9).reverse
    #Toodoo: REFACTOR ME INTO HELPER METHOD FOR SORTING TYPE CHOOSER
    #params[:sort]  #viral, or time, or rising   /memes/by/[x]

    # if params[:sort]   #how do we wish to mutate-sort our localvar, @memes?
    #   #if it exists
    #   case (params[:sort])
    #   when "viral"
    #     #sort virally
    #     @memes = @memes.sort_by {|meme| - meme.reactions.count}
    #   when "newest"
    #     #sort chrono
    #     @memes = @memes.sort_by(&:created_at).reverse
    #   when "oldest"
    #     @memes = @memes.sort_by(&:created_at)
    #   when "rising"
    #     #sort rising
    #     @memes = @memes.sort_by {|meme| - meme.reactions.where(created_at: (Time.now - 1.hour)..Time.now).count}
    #   else
    #     flash[:warning] = "What exactly are you trying to do here, pal?"
    #   end
    # end
  end

  # def next_memes
  #   @memes = Meme.where(group: @current_group).last(9).reverse
  # end

  def show
  end

  def new
    @meme = Meme.new
  end

  def create
    
    #Return to save template and create new model
    #***Return to refactor to remove this logic from the controller!****
    
    #Create new_meme instance, to be modified later
    @new_meme = Meme.new(tag_params)
    @new_meme.title = title_params
    
    #Capture parameters
    top_text = params[:top_text]
    bottom_text = params[:bottom_text]
    image_uri = params[:images][0]
    filetype_full = params[:filetype]

    filetype = '.' + filetype_full.split('/').last
    
    # File.open('downscaled' + filetype, 'wb') do|f|
    #   f.write(Base64.decode64(image_uri["data:#{filetype_full};base64,".length .. -1]))
    # end

    Meme.generate_meme(image_uri, filetype_full, filetype, top_text, bottom_text)

    # url = Meme.decode_base64_image(image_uri, filetype_full).path
    # binding.pry
    # Meme.create_meme(url, top_text, bottom_text, filetype)
    
    # Meme.set_meme(@new_meme, filetype)

    @new_meme.image = File.open('temporary_meme' + filetype)
    @new_meme.group = Group.find_by(group_slug: params[:group_slug])
    @new_meme.creator = current_user

    # if params[:meme][:image].nil? #if they did not load a template, use paired programming gif
    #   url = 'https://s3.amazonaws.com/groupmeme/paired-programming.gif'
    #   filetype = '.gif'
    # else #otherwise use their uploaded image as the template

    #   #but first check filesize
    #   image_size_in_mb = params[:meme][:image].size / 1000000.0
    #   if image_size_in_mb > 5
    #     flash[:danger] = "The maximum upload size is 5 MB"
    #     @meme = Meme.new
    #     render :new
    #     return
    #   end
      #if the size is fine, proceed
      # url = params[:meme][:image].tempfile.path
      # filetype = '.' + params[:meme][:image].content_type.split('/').last
      # @template = Meme.new(base_params)
      # @template.save
      # url = @template.image.url
      # filetype = '.' + @template.image_content_type.split('/').last
    # end


    if @new_meme.save
      redirect_to meme_path(group_slug: @new_meme.group.group_slug, id: @new_meme.id)
    else
      render :new
    end
  end

  def destroy
    if current_user == @meme.creator #check that user is the creator of the meme
      @meme.destroy_tags
      @meme.destroy
      redirect_to memes_path(@meme.group.group_slug)
    else
      flash.now[:danger] = "You do not have permission to delete this meme"
    end
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
    @meme ||= Meme.find_by_id(params[:id]) if Meme.find_by_id(params[:id])
  end

  def set_group
    # @group = Group.find_by(group_slug: params[:group_slug])
    @current_group ||= Group.find_by(group_slug: params[:group_slug]) if params[:group_slug]
  end

  def meme_params
    params.require(:meme).permit(:image, :title, tags_attributes: [:name])
  end

  def title_params
    params.require(:meme).permit(:image, :title)[:title]
  end

  def tag_params
    params.require(:meme).permit(tags_attributes: [:name])
  end

  def base_params
    params.require(:meme).permit(:image)
  end

  def decode_base64_image(image_uri, filetype_full)
    begin
        decoded_data = Base64.decode64(image_uri["data:#{filetype_full};base64,".length .. -1])
        filetype = '.' + filetype_full.split('/').last
        file = Tempfile.new(['downscaled', filetype]) 
        file.binmode
        file.write(decoded_data)
        file.close
        return file
    ensure
      file.unlink
    end
  end


end
