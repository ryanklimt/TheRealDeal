class User < ActiveRecord::Base
  
  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }
  before_create :create_remember_token
  
  has_many :wallposts, dependent: :destroy
  has_many :posts
  has_many :topics
  
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, :unless => lambda {|u| u.password.nil? }
  has_secure_password
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def feed
    wallposts
  end
  
  
  private
  
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
  
end
