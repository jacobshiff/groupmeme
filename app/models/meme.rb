class Meme < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :comments
  has_many :meme_tags
  has_many :tags, through: :meme_tags
  has_many :reactions
  belongs_to :group

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
      "<strong>You</strong> and <strong>#{self.reactions.count - 1} other #{plural('person')}</strong> like this image".html_safe
    end
  end

  def message_helper
    num = self.reactions.count
    if num > 1
      "<strong>#{num} people</strong> like this image"
    else
      "<strong>#{num} person</strong> likes this image"
    end
  end

  def plural(word)
    if self.reactions.count > 1
      num = self.reactions.count - 1
    else
      num = self.reactions.count
    end
    str = ActionController::Base.helpers.pluralize(num, word)
    parts = str.split
    parts[1]
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
