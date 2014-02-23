class Wall < ActiveRecord::Base
  attr_accessible :name, :description, :access_code, :admin_id, :user_id, :alias
  has_many :posts
  has_many :users, through: :memberships
  has_many :memberships
  validates :name, :alias, :access_code, presence: true
end
