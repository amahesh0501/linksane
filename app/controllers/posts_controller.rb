class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:show, :edit ]

  def index
    redirect_to wall_path(Wall.find params[:wall_id])
  end

  def show
    @wall = Wall.find(params[:wall_id])
    @post = Post.find params[:id]
    @user = User.find(@post.user_id)
    @comments = @post.comments.order("created_at DESC")
    @comment = Comment.new
    @can_edit = @post.can_edit?(current_user)

    redirect_to wall_path(@wall) unless @post.can_access?(current_user, @wall)

  end

  def new
    redirect_to wall_path(Wall.find params[:wall_id])
  end

  def create
    @wall = Wall.find params[:wall_id]
    @post = @wall.posts.build(link: params[:post][:link], description: params[:post][:description], user_id: current_user.id, wall_id: @wall.id, image: params[:post][:image] )

    if @post.save
      redirect_to wall_path(@wall)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to wall_path(@wall)
    end
  end

  def edit
    @post = Post.find params[:id]
    @wall = Wall.find(params[:wall_id])

    redirect_to wall_post_path(@wall, @post) unless @post.can_edit?(current_user)
  end

  def update
    @post = Post.find params[:id]
    @wall = Wall.find(params[:wall_id])
    if @post.update_attributes params[:post]
      redirect_to wall_post_path(@wall, @post)
    else
      redirect_to edit_wall_post_path(@wall, @post)
      flash[:errors] = @post.errors.full_messages
    end
  end

  def destroy
    wall = Wall.find(params[:wall_id])
    post = Post.find params[:id]
    post.destroy
    redirect_to wall_path(wall)
  end

end