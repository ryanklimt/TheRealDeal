class User < ActiveRecord::Base
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_create { generate_token(:auth_token) }
  
  has_many :wallposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :posts
  has_many :topics
  
  default_scope -> { order('created_at DESC') }
  
  validates :username, presence: true, format: { with: /^[a-zA-Z0-9_-]+$/, multiline: true}, uniqueness: { case_sensitive: false }, length: { maximum: 20 },
  :exclusion => %w(about settings home forums subforums users relationships posts wallposts topics contact help login logout sessions signup admin followers following)
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, :unless => lambda {|u| u.password.nil? }
  
  validate :gender, inclusion: %w(Male Female)
  
  has_secure_password
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def feed
    Wallpost.from_users_followed_by(self).where("directed_user_id = user_id")
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
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def send_verify_email
    generate_token(:email_auth_token)
    save!
    UserMailer.verify_email(self).deliver
  end
  
  private
  
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
    
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
  
end
