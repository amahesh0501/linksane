class Wall < ActiveRecord::Base
  attr_accessible :name, :description, :access_code, :admin_id, :user_id, :alias
  has_many :posts, dependent: :destroy
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy
  validates :name, :alias, :access_code, presence: true
  validates :name, length: { maximum: 20 }

  def get_current
    memberships = Membership.where(wall_id: self.id)
    current_memberships = memberships.where(revoked: false)
    current_memberships.map!{|membership| User.find(membership.user_id)}
  end

  def get_revoked
    memberships = Membership.where(wall_id: self.id)
    banned_memberships = memberships.where(revoked: true)
    banned_memberships.map!{|membership| User.find(membership.user_id)}
  end

  def is_admin?(user)
    self.admin_id == user.id ? true : false
  end

  def grant_access(code)
    code == self.access_code ? true : false
  end

end
