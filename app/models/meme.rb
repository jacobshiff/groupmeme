class Meme < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :comments
  has_many :meme_tags
  has_many :tags, through: :meme_tags
  has_many :reactions
  belongs_to :group
  accepts_nested_attributes_for :tags

  #paperclip validations; must include for upload
  has_attached_file :image
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def update_reactions(user)
    user_reacted?(user) ? unreact(user) : react(user)
  end

  def reactions_message(user)
    if !user_reacted?(user)
      message_helper.html_safe
    else
      other_message_helper.html_safe
    end
  end

  def message_helper
    num = self.reactions.count
    if num > 1
      "<strong>#{num} people</strong> like this"
    elsif num == 0
      "Be the first to like this"
    else
      "<strong>#{num} person</strong> likes this"
    end
  end

  def other_message_helper
    num = self.reactions.count - 1
    if num == 1
      "<strong>You</strong> and <strong>1 other person </strong> like this"
    elsif num == 0
      "<strong>You</strong> like this"
    else
      "<strong>You</strong> and <strong>#{num} other people</strong> like this"
    end
  end

  def heart_class(user)
    if user_reacted?(user)
      "glyphicon glyphicon-heart"
    else
      "glyphicon glyphicon-heart-empty"
    end
  end

  # def popularity_score
  #   #self.
  # end

  private
  def user_reacted?(user)
    self.reactions.where(user: user).any?
  end

  def react(user)
    self.reactions.create(user_id: user.id)
  end

  def unreact(user)
    self.reactions.find_by(user_id: user.id).destroy
  end

end
