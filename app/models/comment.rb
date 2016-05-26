class Comment < ActiveRecord::Base
  #relationships here
  belongs_to :user
  belongs_to :meme
  belongs_to :group

  validates :content, presence: true
end
