class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.meme_id = params[:id]
    @comment.group = current_group
    @comment.save
    render json: {content: @comment.content, user: @comment.user, user_avatar: @comment.user.avatar, time: @comment.created_at}
    #binding.pry
    #create new comment
    #render JSON with comment content, 
  end

  private 

  def comment_params
    params.require(:comment).permit(:content)
  end
end
