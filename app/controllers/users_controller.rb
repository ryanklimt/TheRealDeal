class UsersController < ApplicationController
  
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :admin_user, only: :destroy
  
  # GET /users
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # GET /signup
  def new
    @user = User.new
  end
  
  # POST /signup
  def create
    @user = User.new(user_params)
    if @user.save then
      sign_in @user
      flash[:success] = "Welcome to the site #{@user.username}!"
      redirect_to user_profile(@user)
    else
      render 'new'
    end
  end
  
  # GET /:username
  def show
    @user = User.find_by_username(params[:username])
    @wallpost = @user.wallposts.build
    @wallposts = @user.wallposts.paginate(page: params[:page])
  end
  
  # GET /settings
  def edit
    @user = User.find(current_user.id)
  end
  
  # PATCH /settings
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(update_params) then
      flash[:success] = "Successfully updated!"
      redirect_to user_profile(@user)
    else
      render 'edit'
    end
  end
  
  # DELETE /:username
  def destroy
    @user = User.find_by_username(params[:username])
    if current_user.admin? && !current_user?(@user) && !@user.admin? then
      @user.destroy
      flash[:success] = @user.username + " deleted!"
      redirect_to users_path
    else
      flash[:danger] = "You tried to delete yourself you idiot!"
      redirect_to root_path
    end
  end
  
  # GET /:username/following
  def following
    @t = "Following"
    @user = User.find_by_username!(params[:username])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  # GET /:username/followers
  def followers
    @t = "Followers"
    @user = User.find_by_username!(params[:username])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  # PUT /:username/admin
  def admin
    @user = User.find_by_username(params[:username])
    if current_user.admin? && @user.update_attributes(:admin => true) then
      flash[:success] = "Successfully updated!"
      redirect_to user_profile(@user)
    else
      render 'edit'
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    
    def update_params
      params.require(:user).permit(:username, :firstname, :lastname, :email, :private)
    end
  
end
