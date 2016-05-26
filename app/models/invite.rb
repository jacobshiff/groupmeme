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

  #This method is always called when an invite is saved and sets the recipient ID
  # to an existing user if the recipient already has an account (based on email)
  def check_user_existence
    recipient = User.find_by(email: recipient_email)
    if recipient
      self.recipient_id = recipient.id
    end
  end

end
