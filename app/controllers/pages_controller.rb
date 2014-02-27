class PagesController < ApplicationController

  def index
    if user_signed_in?
      @posts = current_user.get_posts
      unless current_user.oauth_token == nil
        current_user.get_fb_links
        @fblinks = current_user.links.order(:created_time).reverse
      end
    else
      @logged_in_user = false
    end
  end
end