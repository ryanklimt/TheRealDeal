module SessionsHelper
  
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def signed_in_user
    unless signed_in?
      redirect_to login_path, :flash => { :info => "Please sign in." }
    end
  end
  
  def admin_user
    redirect_to root_path, :flash => { warning: "You must be an admin to do that." } unless current_user.admin?
  end
  
  def ensure_logged_in
    redirect_to login_path, :flash => { warning: "You must be logged in to do that." } unless signed_in?
  end
  
end
