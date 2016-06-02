class ReactionDecorator < SimpleDelegator

  attr_accessor :meme, :user

  def initialize(meme, user)
    @meme = meme
    @user = user
    @count = meme.reactions.count
  end


  def thumb_html
    "<span class='react-btn' meme_id='#{meme.id}'><span class='#{thumb_class}'></span></span>".html_safe
  end

  def thumb_class
    LikeCreator.new(meme, user).user_reacted? ? "fa fa-thumbs-up" : "fa fa-thumbs-o-up"
  end

  def message_html
    "<span class='reactions-message' meme_message_id='#{meme.id}'>#{reactions_message}
    </span>".html_safe
  end

  def reactions_message
    if LikeCreator.new(meme, user).user_reacted?
      reacted_message.html_safe
    else
      not_reacted_message.html_safe
    end
  end

  def not_reacted_message
    if @count > 1
      "<strong>#{@count} people</strong> like this"
    elsif @count == 0
      "Be the first to like this"
    else
      "<strong>#{@count} person</strong> likes this"
    end
  end

  def reacted_message
    num = @count - 1
    if num == 1
      "<strong>You</strong> and <strong>1 other person </strong> like this"
    elsif num == 0
      "<strong>You</strong> like this"
    else
      "<strong>You</strong> and <strong>#{num} other people</strong> like this"
    end
  end

end
