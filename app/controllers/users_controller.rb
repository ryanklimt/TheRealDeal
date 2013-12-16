class UsersController < ApplicationController
  
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :admin_user, only: :destroy
  
  # GET /users
  def index
    if params[:query].present?
      @users = User.search(params[:query], page: params[:page])
    else
      @users = User.all.paginate(page: params[:page], per_page: 15)
    end
  end
  
  # GET /signup
  def new
    @user = User.new
  end
  
  # POST /signup
  def create
    @user = User.new(user_params)
    if @user.save then
      @user.send_verify_email
      sign_in(@user, false)
      flash[:success] = "Welcome to the site #{@user.username}! An email has been sent to verify your account."
      redirect_to user_path(@user.username)
    else
      render 'new'
    end
  end
  
  # GET /:username
  def show
    @user = User.find_by_username(params[:username])
    @wallpost = @user.wallposts.build
    @wallposts = Wallpost.where("directed_user_id = ? or user_id = ?", @user.id, @user.id).paginate(page: params[:page])
  end
  
  # GET /settings
  def edit
    @user = User.find_by_username(current_user.username)
  end
  
  # PATCH /settings
  def update
    @user = User.find_by_username(current_user.username)
    if @user.update_attributes(update_params) then
      flash[:success] = "Successfully updated!"
      redirect_to user_path(@user.username)
    else
      @user.username = current_user.username
      render 'edit'
    end
  end
  
  def verify
    @user = User.find_by_email_auth_token!(params[:email_auth_token])
    @user.update_attributes(verify_email: true)
    flash[:success] = "Email has been verified!"
    redirect_to user_path(@user.username)
  end
  
  # DELETE /:username
  def destroy
    @user = User.find_by_username(params[:username])
    if current_user.admin? && !current_user?(@user) && !@user.admin? then
      @user.destroy
      flash[:success] = @user.username + " deleted!"
      redirect_to users_path
    else
      flash[:danger] = "You tried to cannot delete yourself!"
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
  
  # PUT /:username
  def admin
    @user = User.find_by_username(params[:username])
    if current_user.admin? && @user.update_attributes(:admin => true) then
      flash[:success] = "Successfully updated!"
      redirect_to user_path(@user.username)
    else
      render 'edit'
    end
  end
  
  def autocomplete
    render json: User.search(params[:query], autocomplete: true, limit: 10).map(&:username)
  end
  
  private
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
    
    def update_params
      params.require(:user).permit(:username, :firstname, :lastname, :email, :private, :city, :state, :country, :gender, :birthday, :bio)
    end
  
end
