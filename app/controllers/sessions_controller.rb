class SessionsController < ApplicationController
  
  # GET /login
  def new
  end
  
  # POST /login
  def create
    # Checks email first and if nothing checks username
    @user ||= User.first(:conditions => [ "lower(username) = ?", params[:session][:email_username].downcase]) unless @user = User.find_by(email: params[:session][:email_username].downcase)
    if @user and @user.authenticate(params[:session][:password])
      if params[:session][:remember_me] == '1' then
        sign_in(@user, true)
      else
        sign_in(@user, false)
      end
      flash[:success] = "Welcome " + @user.username + "!"
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid username or password!"
      render 'new'
    end
  end
  
  # DELETE /logout
  def destroy
    sign_out
    flash[:success] = "You've logged out!"
    redirect_to root_path
  end
  
end
