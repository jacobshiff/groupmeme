class TagsController < ApplicationController

  def index
    group_id = current_group.id
    @tags = Tag.search(params[:term], group_id)
    render json: @tags.pluck(:name)
  end

  def show
    @memes = Tag.find_memes_for_tag_slug(params[:tag])
    @tag = Tag.find_by(slug: params[:tag])
  end
end
