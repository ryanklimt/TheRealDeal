class Subforum < ActiveRecord::Base
  
  belongs_to :forum
  belongs_to :user
  has_many :topics, :dependent => :destroy
  
  validates :name, presence: true, length: { maximum: 64 }
  validates :description, presence: true, length: { maximum: 512 }
  
end
