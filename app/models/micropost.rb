class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  # Returns microposts from the users being Followed by the given user.
  def self.from_users_Followed_by(user)
    Followed_user_ids = "SELECT Followed_id FROM relationships
                         WHERE Follower_id = :user_id"
    where("user_id IN (#{Followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
