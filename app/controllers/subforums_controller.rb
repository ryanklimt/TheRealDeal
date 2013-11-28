class SubforumsController < ApplicationController
  
  before_action :ensure_logged_in, only: [:new, :create, :edit, :update, :destroy]
  
  def new
    forum = Forum.find(params[:forum_id])
    @sforum = forum.subforums.build
  end
  
  def create
    forum = Forum.find(params[:forum_id])
    @sforum = forum.subforums.build(subforum_params)
    @sforum.user = current_user
    if @sforum.save then
      flash[:success] = @sforum.name + " created!"
      redirect_to @sforum
    else
      render 'new'
    end
  end
  
  def show
    @sforum = Subforum.find(params[:id])
  end
  
  def edit
    @sforum = Subforum.find(params[:id])
  end
  
  def update
    @sforum = Subforum.find(params[:id])
    if current_user?(@sforum.user) and @sforum.update_attributes(subforum_params) then
      flash[:success] = "Successfully Updated!"
      redirect_to subforum_path(@sforum)
    else
      render 'edit'
    end
  end
  
   def destroy
    @sforum = Subforum.find(params[:id])
    if current_user.admin? or current_user?(@sforum.user) then
      @sforum.destroy
      flash[:success] = @sforum.name + " destroyed!"
      redirect_to forum_path(@sforum.forum_id)
    else
      redirect_to forum_path(@sforum.forum_id)
    end
  end
  
  private
  
  def subforum_params
    params.require(:subforum).permit(:name, :description)
  end
  
end