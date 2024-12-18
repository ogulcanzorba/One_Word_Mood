class User < ApplicationRecord
  # Associations
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :saved_posts_relationships, class_name: 'SavedPost', foreign_key: 'user_id'
  has_many :saved_posts, through: :saved_posts_relationships, source: :post

  has_many :active_follows, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_follows, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy

  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower

  # Devise Modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Instance Methods
  def total_posts
    posts.count
  end

  def total_mood_expressions_received
    posts.joins(:likes).count
  end

  def avatar_url
    avatar.attached? ? avatar : "default_avatar.jpg"
  end

  def followers_count
    followers.count
  end

  def following_count
    following.count
  end

  def follow(user)
    following << user unless self == user || following?(user)
  end

  def unfollow(user)
    active_follows.find_by(followed_id: user.id)&.destroy
  end

  def following?(user)
    following.include?(user)
  end
end
