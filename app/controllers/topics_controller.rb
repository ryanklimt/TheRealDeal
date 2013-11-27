class TopicsController < ApplicationController
    
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
    params.require(:topic).permit(:title, :posts_attributes => [:id, :user_id, :topic_id, :content])
  end
    
end
