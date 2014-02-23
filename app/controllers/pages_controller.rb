class PagesController < ApplicationController

  def index
    if user_signed_in?
      # @logged_in_user= true
      @user = current_user
      memberships = Membership.where(user_id: current_user.id)
      @walls = []
      memberships.each {|membership| @walls << Wall.find(membership.wall_id) if membership.revoked == false}

    else
      @logged_in_user = false
    end
  end
end