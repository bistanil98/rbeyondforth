class CommentsController < ApplicationController
  before_action :user_is_logged_in?, :only => ["create","destroy"]

  def create
    @blog =  Blog.friendly.find(params[:blog_id])
    puts "Comment parameters:  #{comment_params}"
    @comment = @blog.comments.create(comment_params)
    redirect_to blog_path(@blog)
  end

  def destroy
    @blog = Blog.friendly.find(params[:blog_id])
    @comment = @blog.comments.find(params[:id])
    @comment.destroy
    redirect_to blog_path(@blog)
  end

  private
    def comment_params
      params[:user_id] = session[:user_id]
      puts "User id: #{params[:user_id]}"
      params.require(:comment).permit(:comment_body).merge(:user_id => session[:user_id])
    end

end
