class UsersController < ApplicationController
  
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save then
      sign_in @user
      flash[:success] = "Succesfully created an account!"
      redirect_to '/' + @user.username
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find_by_username!(params[:username])
    @wallposts = @user.wallposts.paginate(page: params[:page])
  end
  
  def edit
    @user = User.find_by_username(params[:username])
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(update_params) then
      flash[:success] = "Successfully updated!"
      redirect_to '/' + @user.username
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find_by_username(params[:username])
    if current_user.admin? && !current_user?(@user) then
      @user.destroy
      flash[:success] = @user.username + " deleted!"
      redirect_to root_path
    else
      flash[:danger] = "You tried to delete yourself you idiot!"
      redirect_to root_path
    end
  end
  
  def following
    @t = "Following"
    @user = User.find_by_username!(params[:username])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @t = "Followers"
    @user = User.find_by_username!(params[:username])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    
    def update_params
      params.require(:user).permit(:username, :firstname, :lastname, :email, :private)
    end
    
    def correct_user
      @user = User.find(current_user.id)
      if(!current_user.admin? && !current_user?(@user))
        redirect_to root_path
      end
    end
  
end
