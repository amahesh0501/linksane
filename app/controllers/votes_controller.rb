class VotesController < ApplicationController
  def create
    vote = Vote.new(user_id: current_user.id, post_id: params[:post_id])
    if vote.save
      post = Post.find(params[:post_id])
      Vote.create(user_id: current_user.id, post_id: post.id)
      render :partial => 'vote', :locals => { :post => post }
    end
  end
end

