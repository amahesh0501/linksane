class Wall < ActiveRecord::Base
  attr_accessible :name, :description, :access_code, :admin_id, :user_id, :alias
  has_many :posts, dependent: :destroy
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy
  validates :name, :alias, :access_code, presence: true
  validates :name, length: { maximum: 20 }
end
