class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "Follower_id", dependent: :destroy
  has_many :Followed_users, through: :relationships, source: :Followed
  has_many :reverse_relationships, foreign_key: "Followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :Followers, through: :reverse_relationships, source: :Follower
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Micropost.from_users_Followed_by(self)
  end

  def Following?(other_user)
    relationships.find_by(Followed_id: other_user.id)
  end

  def Follow!(other_user)
    relationships.create!(Followed_id: other_user.id)
  end

  def unFollow!(other_user)
    relationships.find_by(Followed_id: other_user.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
