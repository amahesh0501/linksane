require 'debugger'
require 'time'


class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body
  devise :omniauthable, :omniauth_providers => [:facebook]

  validates_presence_of :name, :on => :creation



  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :walls, through: :memberships
  has_many :memberships, dependent: :destroy
  has_many :links

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      # user.image = auth.info.image # assuming the user model has an image
    end
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil # or consider a custom null object
  end

  def friends_count
    facebook { |fb| fb.get_connection("me", "friends").size }
  end

  def get_fb_links
    all_fb_links =  self.facebook.get_connections("me", 'home')
    if Link.find_by_user_id(self.id)
      last_100 = Link.find_all_by_user_id(self.id).reverse.take(100)
      last_100.map! {|x| x['link_id'] }
      p last_100
      p "----"
      all_fb_links.each do |post|
          p post['id']
        unless last_100.include?(post['id'])
          if (post['caption'] && post['link'] !~ /https:\/\/www.facebook.com/) #|| post['message'].match(/http:\/\// || /https:\/\// )
            Link.create(user_id: self.id, link_id: post['id'], sender_name: post['from']['name'], sender_id: post['from']['id'], message: post['message'], name: post['name'], caption: post['caption'], picture_url: post['picture'] , url: post['link'], description: post['description'], created_time: Time.parse(post['created_time'])  )
          end
        end
      end

    else
      all_fb_links.each do |post|
        if (post['caption'] && post['link'] !~ /https:\/\/www.facebook.com/) #|| post['message'].match(/http:\/\// || /https:\/\// )
          Link.create(user_id: self.id, link_id: post['id'], sender_name: post['from']['name'], sender_id: post['from']['id'], message: post['message'], name: post['name'], caption: post['caption'], picture_url: post['picture'] , url: post['link'], description: post['description'], created_time: Time.parse(post['created_time'])  )
        end
      end
    end

  end









end





# if Link.find_by_user_id(self.id)
#   time = Time.parse(all_fb_links[counter]['created_time'])
#   p true if time > self.links.last.created_time
#   p time
#   p "*" * 200
#   if time > self.links.last.created_time
#     post = all_fb_links[counter]
#     if (post['caption'] && post['link'] !~ /https:\/\/www.facebook.com/)
#       Link.create(user_id: self.id, url: post['link'], link_id: post['id'], sender_name: post['from']['name'], sender_id: post['from']['id'], message: post['message'], name: post['name'], caption: post['caption'], picture_url: post['link'], description: post['description'], created_time: Time.parse(post['created_time'])  )
#     end
#     counter+=1
#   end
