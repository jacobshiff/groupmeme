class Invite < ActiveRecord::Base
  belongs_to :group
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates_presence_of :recipient_email
  before_create :generate_token
  before_save :check_user_existence

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def check_user_existence
    recipient = User.find_by(email: recipient_email)
    if recipient
      self.recipient_id = recipient.id
   end
  end

end
