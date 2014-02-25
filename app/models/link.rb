class Link < ActiveRecord::Base
  attr_accessible :url, :link_id, :sender_name, :sender_id, :message, :name, :caption, :picture_url, :description, :created_time, :user_id

  belongs_to :user


end
