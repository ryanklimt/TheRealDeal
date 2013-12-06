class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @user ||= User.find_by(username: params[:session][:email_username].downcase) unless @user = User.find_by(email: params[:session][:email_username].downcase)
    if @user and @user.authenticate(params[:session][:password])
      sign_in @user
      flash[:success] = "Welcome " + @user.username.humanize + "!"
      redirect_to "/" + @user.username
    else
      flash.now[:danger] = "Invalid username or password!"
      render 'new'
    end
  end
  
  def destroy
    sign_out
    flash[:success] = "You've logged out!"
    redirect_to root_path
  end
  
  
end
