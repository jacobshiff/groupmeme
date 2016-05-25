class Tag < ActiveRecord::Base
  has_many :meme_tags
  has_many :memes, through: :meme_tags
  belongs_to :group

  def self.search(term, group_id)
    where("name ILIKE ? AND group_id = ?", "%#{term}%", group_id)
  end

end
