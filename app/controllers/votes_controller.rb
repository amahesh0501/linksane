class VotesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    vote = Vote.new(user_id: current_user.id, post_id: post.id)
    if vote.save
      render :partial => 'vote', :locals => { :post => post }
    end
  end
end

