class Tag < ActiveRecord::Base
  has_many :meme_tags
  has_many :memes, through: :meme_tags
  belongs_to :group

  def self.search(term)
    where("name ILIKE ?", "%#{term}%")
  end

end
