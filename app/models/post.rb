class Post < ActiveRecord::Base
  attr_accessible :link, :description, :wall_id, :user_id, :image

  belongs_to :user
  belongs_to :wall
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  validates_presence_of :description

  has_attached_file :image, :styles => { :medium => "400x400>", :thumb => "100x100>" }

end
