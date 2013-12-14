class Subscription < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :subforum
  
  validates :subforum_id, presence: true
  validates :user_id, presence: true
  
end
