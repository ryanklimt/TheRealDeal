class WallpostsController < ApplicationController
  
  before_action :signed_in?, only: [:create, :destroy]
  
  def create
    @wallpost = current_user.wallposts.build(wallpost_params)
    if @wallpost.save then 
      flash[:success] = "Post Created!"
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
    @wallpost = Wallpost.find(params[:id])
    if current_user?(@wallpost.user) or current_user.admin? then
      @wallpost.destroy
      flash[:success] = "Post Deleted!"
      redirect_to request.original_url
    else
      flash[:danger] = "You can't delete other peoples posts!"
      redirect_to current_user
    end
  end
  
  private
  
  def wallpost_params
    params.require(:wallpost).permit(:content)
  end
  
end
