class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :memes
  has_many :meme_tags, through: :memes
  has_many :tags, through: :meme_tags
  belongs_to :group_creator, class_name: 'User'

  #paperclip
  has_attached_file :image, default_url: "https://s3.amazonaws.com/groupmeme/default-avatar.png"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  def to_slug
    revised = self.title.downcase.tr("()&.*',+!", ' ')
    array = revised.split(" ")
    array.join("-")
  end

  def all_tags
    t = self.memes.collect{|meme| meme.tags.collect{|tag| tag} }
    # the above returns an array of arrays with many repeats
    t = t.flatten
    t = t.uniq
    t
  end

#### I (Rachel) wrote this code in a daze...very clearly it is not needed at all
  # def self.find_groups_for_user(user)
  #   #user passed in as ID
  #   memberships = Membership.where(user_id: user)
  #   group_ids = memberships.collect{|m| m.group_id}
  #   groups = group_ids.collect{|id| Group.find(id)}
  #   return groups
  #   #select * from groups inner join memberships where memberships.user_id == user.id
  # end

  # def self.find_users_for_group(group)
  #   memberships = Membership.where(group: group)
  #   user_ids = memberships.collect{|m| m.user_id}
  #   users = user_ids.collect{|id| User.find(id)}
  #   return users
  # end

  def all_tags
    self.memes.collect{|meme| meme.tags.collect{|tag| tag} }
  end


end
