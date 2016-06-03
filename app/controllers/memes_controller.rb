require 'open-uri'

require 'meme_captain'

class MemesController < ApplicationController
    before_action :set_group, only: [:index, :new]
    before_action :set_meme, only: [:show, :destroy, :react]
    before_action :require_login_and_access

  def index
    @memes = Meme.where(group: @current_group).order(id: :desc)
  end

  def show
  end

  def new
    @meme = Meme.new
  end

  def create
    binding.pry
    #Return to save template and create new model?
    meme_generator_result = MemeGenerator.new(params, tag_params, current_user).generate
    if meme_generator_result[:meme].nil?
      flash.now[:danger] = meme_generator_result[:notice]
      @meme = Meme.new
      render :new and return
    else
      if meme_generator_result[:meme].save
        redirect_to meme_path(group_slug: meme_generator_result[:meme].group.group_slug, id: meme_generator_result[:meme].id)
      else
        flash.now[:danger] = "Something went wrong. Please try again."
        render :new
      end
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
    LikeCreator.new(@meme, current_user).update_reactions
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

  def tag_params
    params.require(:meme).permit(tags_attributes: [:name])
  end

end
