class WallsController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    @wall = Wall.find params[:id]
    @posts = @wall.posts.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @user = current_user
    @post = Post.new
    @error = flash[:access_errors]
    @membership = Membership.find_by_user_id_and_wall_id(current_user.id, @wall.id)
    if user_signed_in?
      if @membership && !@membership.revoked
        render :show
      elsif @membership && @membership.revoked
        render :revoked
      else
        redirect_to new_wall_membership_path(@wall, @membership)
        #redirect_to '/walls/' + @wall.id.to_s + '/memberships/new'
      end
    else
      redirect_to '/auth/login'
    end
  end

  def new
    if user_signed_in?
      @wall = Wall.new
      @user_id = current_user.id
    else
      redirect_to '/auth/login'
    end
  end

  def create
    if user_signed_in?
      @user = current_user
      @wall = @user.walls.build(params[:wall])
      if @wall.save
        Membership.create(wall_id: @wall.id, user_id: current_user.id)
        redirect_to wall_path(@wall)
      else
        flash[:errors] = @wall.errors.full_messages
        redirect_to new_wall_path(@wall)
      end
    else
      redirect_to '/auth/login'
    end
  end

  def edit
    @wall = Wall.find params[:id]
    memberships = Membership.where(wall_id: @wall.id)
    current_memberships = memberships.where(revoked: false)
    banned_memberships = memberships.where(revoked: true)
    @members = []
    @banned_members = []
    current_memberships.each {|membership| @members << User.find(membership.user_id)}
    banned_memberships.each {|banned_membership| @banned_members << User.find(banned_membership.user_id)}


    unless @wall.admin_id == current_user.id
      redirect_to root_path
    end
  end

  def update
    @wall = Wall.find params[:id]
    if @wall.update_attributes(params[:wall])
      redirect_to wall_path(@wall)
    else
      flash[:errors] = @wall.errors.full_messages
      redirect_to edit_wall_path(@wall)
    end
  end

  def destroy
    @wall = Wall.find params[:id]
    @wall.destroy
    redirect_to root_path
  end



end