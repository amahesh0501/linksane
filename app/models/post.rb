class Post < ActiveRecord::Base
  attr_accessible :link, :description, :wall_id, :user_id, :image

  belongs_to :user
  belongs_to :wall
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  validates_presence_of :description

  has_attached_file :image, :styles => { :medium => "400x400>", :thumb => "100x100>" }


  def can_access?(user, wall)
    membership = Membership.where(wall_id: wall.id, user_id: user.id).first
    membership && membership.revoked == false ? true : false
  end

  def can_edit?(user)
    self.user_id == user.id ? true : false
  end



end
