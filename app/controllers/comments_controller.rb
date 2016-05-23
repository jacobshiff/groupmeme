class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.meme_id = params[:id]
    @comment.group = current_group
    @comment.save
    time = @comment.created_at.strftime("%I:%M %p on %b %d, %Y")
    render json: {content: @comment.content, user: @comment.user, user_avatar: @comment.user.avatar, username: @comment.user.username, time: time}
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
