class MemeTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :meme
  belongs_to :group
end
