class Membership < ActiveRecord::Base
  attr_accessible :user_id, :wall_id, :last_visit_time
  belongs_to :user
  belongs_to :wall

  def can_access?(membership)
    membership && !membership.revoked ? true : false
  end

  def revoked?(membership)
    membership.revoked
  end




end
