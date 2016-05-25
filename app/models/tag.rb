class Tag < ActiveRecord::Base
  has_many :meme_tags
  has_many :memes, through: :meme_tags
  belongs_to :group

  def self.search(term, group_id)
    where("name ILIKE ? AND group_id = ?", "%#{term}%", group_id)
  end

  def self.find_memes_for_tag_slug(slug)
    tag = Tag.find_by(slug: slug)
    memetags = MemeTag.where(tag: tag)
    meme_ids = memetags.collect{|t| t.meme_id }
    memes = meme_ids.collect{|id| Meme.find(id)}
    return memes
  end

  def to_slug
    revised = self.name.downcase.tr("()&.*',+!", ' ')
    array = revised.split(" ")
    array.join("-")
  end

end
