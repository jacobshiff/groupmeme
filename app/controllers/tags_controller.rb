class TagsController < ApplicationController

  def index
    @tags = Tag.search(params[:term])
    render json: @tags.map(&:name).uniq
  end
end
