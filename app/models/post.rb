class Post < ActiveRecord::Base
  attr_accessible :link, :title, :description, :wall_id, :user_id

  belongs_to :user
  belongs_to :wall
  has_many :comments
  has_many :votes
  validates_presence_of :title, :description
end
