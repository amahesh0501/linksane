class ApplicationController < ActionController::Base

  before_filter :get_signed_in_walls

  protect_from_forgery

  #Walls for Sidebar

  def get_signed_in_walls
    if current_user
      memberships = Membership.where(user_id: current_user.id)
      @user_walls_accessible = []
      memberships.each {|membership| @user_walls_accessible << Wall.find(membership.wall_id) if membership.revoked == false}
    end
  end
end
