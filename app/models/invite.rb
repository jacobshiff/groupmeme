class Invite < ActiveRecord::Base
  belongs_to :group
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates_presence_of :recipient_email
  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

end
