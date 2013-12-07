class User < ActiveRecord::Base
  
  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }
  before_create :create_remember_token
  
  has_many :wallposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :posts
  has_many :topics
  
  default_scope -> { order('created_at DESC') }
  
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, :unless => lambda {|u| u.password.nil? }
  
  has_secure_password
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def feed
    Wallpost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end 
  
  private
  
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
  
end
