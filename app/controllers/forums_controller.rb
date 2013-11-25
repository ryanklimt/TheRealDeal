class ForumsController < ApplicationController
  
  def index
    @forums = Forum.all
  end
  
  def new
    @forum = Forum.new
  end
  
  def create
    @forum = Forum.new(forum_params)
    if @forum.save then
      flash[:success] = @forum.name + " forum created!"
      redirect_to @forum
    else
      render 'new'
    end
  end
  
  def show
    @forum = Forum.find(params[:id])
  end
  
  def edit
    @forum = Forum.find(params[:id])
  end
  
  def update
  end
  
  def destroy
    @forum = Forum.find(params[:id])
    if current_user.admin? then
      @forum.destroy
      flash[:success] = @forum.name + " destroyed!"
      redirect_to forums_path
    else
      redirect_to forums_path
    end
  end
  
  private
  
  def forum_params
    params.require(:forum).permit(:name, :description)
  end
  
end
