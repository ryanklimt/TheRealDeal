class ForumsController < ApplicationController
  
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @forums = Forum.all
  end
  
  def new
    @forum = Forum.new
  end
  
  def create
    @forum = Forum.new(forum_params)
    if @forum.save and current_user.admin? then
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
    @forum = Forum.find(params[:id])
    if current_user.admin? and @forum.update_attributes(forum_params) then
      flash[:success] = "Successfully Updated!"
      redirect_to forums_path
    else
      render 'edit'
    end
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
