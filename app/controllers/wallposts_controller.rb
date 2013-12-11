class WallpostsController < ApplicationController
  
  before_action :signed_in?, only: [:create, :destroy]
  
  def create
    @wallpost = current_user.wallposts.build(wallpost_params)
    if @wallpost.save then 
      flash[:success] = "Post Created!"
      redirect_to :back
    else
      flash[:danger] = "You need to have content!"
      redirect_to root_path
    end
  end
  
  def destroy
    @wallpost = Wallpost.find(params[:id])
    if current_user?(@wallpost.user) or current_user.admin? or current_user_id?(@wallpost.directed_user_id) then
      @wallpost.destroy
      flash[:success] = "Post Deleted!"
      redirect_to :back
    else
      flash[:danger] = "You can't delete other peoples posts!"
      redirect_to user_path(current_user.username)
    end
  end
  
  private
  
  def wallpost_params
    params.require(:wallpost).permit(:content, :directed_user_id)
  end
  
end
