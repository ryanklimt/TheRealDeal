class Topic < ActiveRecord::Base
  
  belongs_to :forum
  belongs_to :user
  has_many :posts, :dependent => :destroy
  
  validates :title, presence: true
  
  accepts_nested_attributes_for :posts, :reject_if => lambda { |a| a[:content].blank? }, allow_destroy: true
  
end
