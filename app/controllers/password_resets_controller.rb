class PasswordResetsController < ApplicationController
  
  def new
  end
  
  def create
    user ||= User.first(:conditions => [ "lower(username) = ?", params[:email_username].downcase]) unless @user = User.find_by(email: params[:email_username].downcase)
    user.send_password_reset if user
    redirect_to root_path, flash: { info: "Email has been sent with password reset instructions." }
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago then
      redirect_to new_password_reset_path, flash: { danger: "Password reset has expired."}
    elsif @user.update_attributes(password_params)
      @user.update_attributes(:password_reset_token => nil, :password_reset_sent_at => nil)
      redirect_to root_path, flash: { info: "Password has been reset!"}
    else
      render 'edit'
    end
  end
  
  private
  
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  
end
