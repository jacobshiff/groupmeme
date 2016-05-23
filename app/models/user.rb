class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :reactions
  has_many :comments
  has_many :memes, foreign_key: 'creator_id'
  #has_many :received_invites, class_name: 'Invite', foreign_key: 'invitee_id'
  has_many :created_groups, class_name: 'Group', foreign_key: 'group_creator_id'

  #Invitation validations
  belongs_to :invite
  has_many :sent_invites, class_name: 'Invite', foreign_key: 'sender_id'

  # paperclip validations; must include for upload
  has_attached_file :avatar, default_url: "/system/users/avatars/default-avatars/avatar-bono.jpg"
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  # #CarrierWave
  # mount_uploader :avatar, AvatarUploader

  has_secure_password

  # Validations
  validates :username, uniqueness: true
  validates :username, :password, presence: true
  validates :password, length: { in: 6..100 }
  # TEMPORARILY COMMENTING THIS OUT
  # validates :invite_id, presence: true, uniqueness: true

  #Find user_type for user of a given group
  def type(group)
    Membership.find_by(user: self, group: group).user_type
  end

  def type=(new_type, group)
    Membership.find_by(user: self, group: group).user_type = new_type
  end

  #Define invitation_token for new users
  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by(token: token)
  end

  def membership(group)
    Membership.find_by(user: self, group: group)
  end

end
