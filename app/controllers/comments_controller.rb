class CommentsController < ApplicationController
  def create
    post = Post.find params[:comment][:commentable_id]
    comment = Comment.build_from post, current_user.id, params[:comment][:body]
    if comment.save
      flash[:notice] = 'Your comment has been added.'
    else
      flash[:error] = 'There was a problem adding your comment.'
    end
    redirect_to post
  end
end
