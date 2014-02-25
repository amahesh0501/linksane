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
    link_posts = []
    all_fb_links.each do |post|
      if (post['caption'] && post['link'] !~ /https:\/\/www.facebook.com/) #|| post['message'].match(/http:\/\// || /https:\/\// )
        link_posts << post
      end
    end

    return link_posts

  end






end
