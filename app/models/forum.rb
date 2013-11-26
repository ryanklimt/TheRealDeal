class Forum < ActiveRecord::Base
  
  has_many :topics, :dependent => :destroy
  
  validates :name, presence: true
  validates :description, presence: true
  
end
