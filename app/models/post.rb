class Post < ActiveRecord::Base
  
  belongs_to :topic
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 512 }
  
end
