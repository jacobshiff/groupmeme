class TagsController < ApplicationController

  def index
    @tags = Tag.search(params[:term])
    render json: @tags.map(&:name).uniq
  end

  def show
    @memes = Tag.find_memes_for_tag_slug(params[:tag])
    @tag = Tag.find_by(slug: params[:tag])
  end
end
