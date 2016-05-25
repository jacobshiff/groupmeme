class TagsController < ApplicationController

  def index
    group_id = current_group.id
    @tags = Tag.search(params[:term], group_id)
    render json: @tags.map(&:name).uniq
  end
end
