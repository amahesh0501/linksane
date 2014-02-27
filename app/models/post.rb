class Post < ActiveRecord::Base
  attr_accessible :link, :description, :wall_id, :user_id, :image, :video_url

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

  def get_embed_code
    url = self.video_url
    if url != nil
      if url =~ /youtube.com/
        /(?<url>v=)(?<video_id>.+)/ =~ url
        "<iframe width='320' height='180' src='//www.youtube.com/embed/#{video_id}' frameborder='0' allowfullscreen></iframe>"
      elsif url =~ /vimeo.com/
        /(?<url>vimeo\.com\/)(?<video_id>.+)/ =~ url
        "<iframe src='//player.vimeo.com/video/#{video_id}?title=0&amp;byline=0&amp;portrait=0&amp;color=ddf5a2' width='320' height='180' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
      elsif url =~ /youtu.be/
        /(?<url>\.be\/)(?<video_id>.+)/ =~ url
        "<iframe width='320' height='315' src='//www.youtube.com/embed/#{video_id}' frameborder='0' allowfullscreen></iframe>"
      end
    end

  end



end



