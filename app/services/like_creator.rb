class LikeCreator

  attr_accessor :meme, :user

  def initialize(meme, user)
    @meme = meme
    @user = user
  end

  def update_reactions
    user_reacted? ? unreact : react
  end

  def user_reacted?
    meme.reactions.where(user: user).any?
  end

  def react
    meme.reactions.create(user_id: user.id)
  end

  def unreact
    meme.reactions.find_by(user_id: user.id).destroy
  end

end
