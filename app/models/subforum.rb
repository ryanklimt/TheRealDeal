class Subforum < ActiveRecord::Base
  
  belongs_to :forum
  belongs_to :user
  
  has_many :topics, :dependent => :destroy
  
  default_scope -> { order('created_at DESC') }
  
  validates :name, presence: true, length: { maximum: 64 }
  validates :description, presence: true, length: { maximum: 512 }
  
end
