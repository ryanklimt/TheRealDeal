class Topic < ActiveRecord::Base
  
  belongs_to :subforum
  belongs_to :user
  
  has_many :posts, :dependent => :destroy
  
  validates :title, presence: true, length: { maximum: 64 }
  
  default_scope -> { order('created_at DESC') }
  
  accepts_nested_attributes_for :posts, allow_destroy: true
  
end
