class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  def self.find_user_type(user_id, group_id)
    membership = self.find_by(user_id: user_id, group_id: group_id)
    if !!membership
      membership.user_type
    end
  end
end
