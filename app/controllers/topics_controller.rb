class TopicsController < ApplicationController
  
  before_action :admin_user, only: :destroy
  
  def index
  end
  
  def new
    forum = Forum.find(params[:forum_id])
    @topic = forum.topics.build
    post = @topic.posts.build
  end
  
  def create
    forum = Forum.find(params[:forum_id])
    @topic = forum.topics.build(topic_params)
    @topic.last_poster_id = current_user.id
    @topic.last_post_at = Time.now
    @topic.user_id = current_user.id
    post = @topic.posts.build(params[:content])
    if @topic.save and post.save then
      flash[:success] = "Topic Created!"
      redirect_to @topic
    else
      render 'new'
    end
  end
  
  def show
    @topic = Topic.find(params[:id])
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    if current_user.admin? then
      @topic.destroy
      flash[:success] = @topic.title + " destroyed!"
      redirect_to :back
    else
      redirect_to root_path
    end
  end
  
  private
  
  def topic_params
    params.require(:topic).permit(:title)
  end
  
end
