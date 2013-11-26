class PostsController < ApplicationController
  
  def index
  end
  
  def new
    topic = Topic.find(params[:topic_id])
    @post = topic.posts.build
  end
  
  def create
    topic = Topic.find(params[:topic_id])
    @post = topic.posts.build(topic_params)
    @post.user_id = current_user.id
    if @post.save then
      flash[:success] = "Post created!"
      redirect_to topic
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def topic_params
    params.require(:post).permit(:content)
  end
  
end
