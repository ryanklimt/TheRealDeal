class Post < ActiveRecord::Base
  
  belongs_to :topic
  belongs_to :user
  
  default_scope -> { order('created_at DESC') }
  
  validates :content, presence: true, length: { maximum: 512 }
  
end
