class Forum < ActiveRecord::Base
  
  has_many :subforums, :dependent => :destroy
  
  validates :name, presence: true, length: { maximum: 64 }
  validates :description, presence: true, length: { maximum: 512 }
  
  def most_recent_post
    topic = Topic.first(:order => 'last_post_at DESC', :conditions => ['forum_id = ?', self.id])
    return topic
  end
  
end
