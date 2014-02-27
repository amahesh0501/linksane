class WallsController < ApplicationController

  before_filter :authenticate_user!, :only => [:show, :new, :edit ,:manage_wall ]


  def index
    redirect_to root_path
  end

  def show
    @wall = Wall.find params[:id]
    @posts = @wall.posts.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @post = Post.new
    @membership = Membership.find_by_user_id_and_wall_id(current_user.id, @wall.id)
    if @membership
      if @membership.revoked?(@membership)
        render :revoked
      else
        render :show
      end
    else
      redirect_to new_wall_membership_path(@wall)
    end
  end

  def new
    @wall = Wall.new
    @user_id = current_user.id
  end

  def create
    wall = current_user.walls.build(params[:wall])
    if wall.save
      Membership.create(wall_id: wall.id, user_id: current_user.id)
      redirect_to wall_path(wall)
    else
      flash[:errors] = wall.errors.full_messages
      redirect_to new_wall_path(wall)
    end
  end

  def edit
    @wall = Wall.find params[:id]
    memberships = Membership.where(wall_id: @wall.id)
    @members = @wall.get_current
    @revoked_members = @wall.get_revoked
    redirect_to wall_path(@wall) unless @wall.is_admin?(current_user)
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

  def manage_wall
    @admin_walls = Wall.where(admin_id: current_user.id)
    @joined_walls = current_user.walls - @admin_walls
  end

end