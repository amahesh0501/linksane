class MembershipsController < ApplicationController

  def new
    if Membership.find_by_user_id_and_wall_id(current_user.id, params[:wall_id])
      redirect_to wall_path(Wall.find(params[:wall_id]))
    end
    @membership = Membership.new
    @user = current_user
    @wall = Wall.find(params[:wall_id])
  end

  def create
    wall = Wall.find(params[:wall_id])
    if wall.access_code == params[:access_code] && user_signed_in?
      user = current_user
      Membership.create(user_id: user.id, wall_id: wall.id)
    end
    redirect_to wall_path(wall)
  end

  def revoke
    puts params
    @membership = Membership.where(user_id: params[:user_id], wall_id: params[:wall_id])
    if @membership.empty?
      id = nil
    else
      @membership = @membership.first
      id = @membership.user_id
      @membership.revoked = true
      @membership.save
    end
    render json: {user_id: id}.to_json
  end

  def reinstate
    @membership = Membership.where(user_id: params[:user_id], wall_id: params[:wall_id])
    if @membership.empty?
      id = nil
    else
      @membership = @membership.first
      id = @membership.user_id
      @membership.revoked = false
      @membership.save
    end
    render json: {user_id: id}.to_json
  end

  def destroy
    p params
    p "*" * 200
    membership = Membership.find(params[:id])
    membership.destroy
    render json: {wall_id: params[:wall_id], user_id: current_user.id}.to_json

  end

end