class SubforumsController < ApplicationController
  
  before_action :ensure_logged_in, only: [:new, :create, :edit, :update, :destroy]
  
  def new
    forum = Forum.find(params[:forum_id])
    @subforum = forum.subforums.build
  end
  
  def create
    forum = Forum.find(params[:forum_id])
    @subforum = forum.subforums.build(subforum_params)
    @subforum.user = current_user
    if @subforum.save then
      flash[:success] = @subforum.name + " created!"
      redirect_to @subforum
    else
      render 'new'
    end
  end
  
  def show
    @subforum = Subforum.find(params[:id])
  end
  
  def edit
    @subforum = Subforum.find(params[:id])
  end
  
  def update
    @subforum = Subforum.find(params[:id])
    if current_user?(@subforum.user) and @subforum.update_attributes(subforum_params) then
      flash[:success] = "Successfully Updated!"
      redirect_to subforum_path(@subforum)
    else
      render 'edit'
    end
  end
  
   def destroy
    @subforum = Subforum.find(params[:id])
    if current_user.admin? or current_user?(@subforum.user) then
      @subforum.destroy
      flash[:success] = @subforum.name + " destroyed!"
      redirect_to forum_path(@subforum.forum_id)
    else
      redirect_to forum_path(@subforum.forum_id)
    end
  end
  
  private
  
  def subforum_params
    params.require(:subforum).permit(:name, :description)
  end
  
end