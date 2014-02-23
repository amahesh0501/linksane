class PostsController < ApplicationController
  def index
    redirect_to wall_path(Wall.find params[:wall_id])

  end

  def show
    if user_signed_in?
      @post = Post.find params[:id]
      @can_edit = true if @post.user_id == current_user.id
      @comments = @post.comments.order("created_at DESC")
      @comment = Comment.new
      @wall = Wall.find(params[:wall_id])
    else
      redirect_to '/signin'
    end
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
    if user_signed_in?
      @post = Post.find params[:id]
      @wall = Wall.find(params[:wall_id])
    else
      redirect_to '/signin'
    end
  end

  def update
    @post = Post.find params[:id]
    if @post.update_attributes params[:post]
      redirect_to wall_post_path(Wall.find(params[:wall_id]), @post)
    else
      redirect_to edit_wall_post_path(Wall.find(params[:wall_id]), @post)
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