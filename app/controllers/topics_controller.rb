class TopicsController < ApplicationController
  
  before_action :ensure_logged_in, only: [:new, :create, :edit, :update, :destroy]
  
  def new
    sforum = Subforum.find(params[:subforum_id])
    @topic = sforum.topics.build
    post = @topic.posts.build
  end
  
  def create
    sforum = Subforum.find(params[:subforum_id])
    @topic = sforum.topics.build(topic_params)
    @topic.last_poster_id = current_user.id
    @topic.last_post_at = Time.now
    @topic.posts[0].user_id = current_user.id
    if @topic.save then
      flash[:success] = "Topic Created!"
      redirect_to @topic
    else
      render 'new'
    end
  end
  
  def show
    @topic = Topic.find(params[:id])
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    if current_user.admin? or current_user?(@topic.user) then
      @topic.destroy
      flash[:success] = @topic.title + " deleted!"
      redirect_to :back
    else
      flash[:warning] = "You don't have the authority to do that boy!"
      redirect_to root_path
    end
  end
  
  private
  
  def topic_params
    params.require(:topic).permit(:title, :posts_attributes => [:content]).merge(:user_id => current_user.id)
  end
    
end
