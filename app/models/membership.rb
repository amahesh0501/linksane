class Membership < ActiveRecord::Base
  attr_accessible :user_id, :wall_id, :last_visit_time
  belongs_to :user
  belongs_to :wall
end
