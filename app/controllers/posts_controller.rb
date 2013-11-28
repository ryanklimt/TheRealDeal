class PostsController < ApplicationController
  
  before_action :ensure_logged_in, only: [:new, :create, :edit, :update, :destroy]
  
  def new
    topic = Topic.find(params[:topic_id])
    @post = topic.posts.build
  end
  
  def create
    topic = Topic.find(params[:topic_id])
    @post = topic.posts.build(post_params)
    @post.user_id = current_user.id
    if @post.save and topic.update_attributes(last_poster_id: current_user.id, last_post_at: Time.now) then
      flash[:success] = "Post created!"
      redirect_to topic
    else
      render 'new'
    end
  end
    
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if current_user?(@post.user) and @post.update_attributes(post_params) then
      flash[:success] = "Post Updated!"
      redirect_to topic_path(@post.topic_id)
    else
      render 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if current_user?(@post.user) or current_user.admin? then
      @post.destroy
      flash[:success] = "Post Deleted!"
      redirect_to :back
    else
      flash[:danger] = "Something went wrong!"
      redirect_to root_path
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:content).merge(:user_id => current_user.id)
  end
  
end
