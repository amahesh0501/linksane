class MembershipsController < ApplicationController

  def new
    @membership = Membership.new
    @user = current_user
    @wall = Wall.find(params[:wall_id])
    redirect_to wall_path(@wall) if Membership.find_by_user_id_and_wall_id(current_user.id, @wall.id)
  end

  def create
    wall = Wall.find(params[:wall_id])
    Membership.create(user_id: current_user.id, wall_id: wall.id) if wall.grant_access(params[:access_code])
    redirect_to wall_path(wall)
  end

  def revoke
    @membership = Membership.where(user_id: params[:user_id], wall_id: params[:wall_id]).first
    if !@membership
      id = nil
    else
      id = @membership.user_id
      @membership.revoked = true
      @membership.save
    end
    render json: {user_id: id}.to_json
  end

  def reinstate
    @membership = Membership.where(user_id: params[:user_id], wall_id: params[:wall_id]).first
    if !@membership
      id = nil
    else
      id = @membership.user_id
      @membership.revoked = false
      @membership.save
    end
    render json: {user_id: id}.to_json
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.destroy
    render json: {wall_id: params[:wall_id], user_id: current_user.id}.to_json
  end

end