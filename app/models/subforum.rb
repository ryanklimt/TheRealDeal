class Subforum < ActiveRecord::Base
  
  belongs_to :forum
  belongs_to :user
  has_many :topics, :dependent => :destroy
  
  validates :name, presence: true
  validates :description, presence: true
  
end
