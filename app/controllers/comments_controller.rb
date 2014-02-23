class CommentsController < ApplicationController

  def index
    redirect_to wall_post_path(Wall.find(params[:wall_id]), Post.find(params[:post_id]))
  end

  def show
    authenticate_user!
    @comment = Comment.find params[:id]
  end

  def new
    redirect_to wall_post_path(Wall.find(params[:wall_id]), Post.find(params[:post_id]))
  end

  def create
    @wall = Wall.find params[:wall_id]
    @post = Post.find params[:post_id]
    @user = current_user
    @user_id = current_user.id
    @comment = @post.comments.build(description: params[:comment][:description], user_id: current_user.id, post_id: params[:post_id])
    if @comment.save
      redirect_to wall_post_path(@wall, @post)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to wall_post_path(@wall, @post)

    end
  end

  def edit
    authenticate_user!
    @wall = Wall.find(params[:wall_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find params[:id]

    unless @post.user_id == current_user.id
      redirect_to wall_post_path(@wall, @post)
    end

  end

  def update
    @comment = Comment.find params[:id]
    @post = Post.find(@comment.post_id)
    @wall = Wall.find(@post.wall_id)
    if @comment.update_attributes params[:comment]
      redirect_to wall_post_path(@wall, @post)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to edit_wall_post_comment_path(@wall, @post, @comment)
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to wall_post_path(Wall.find(params[:wall_id]), Post.find(params[:post_id]))
  end

end