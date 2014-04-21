class Relationship < ActiveRecord::Base
  belongs_to :Follower, class_name: "User"
  belongs_to :Followed, class_name: "User"
  validates :Follower_id, presence: true
  validates :Followed_id, presence: true
end
