class User < ApplicationRecord
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  def total_posts
    posts.count
  end

  def total_mood_expressions_received
    posts.joins(:likes).count
  end
  def avatar_url
    avatar.attached? ? avatar : "default_avatar.jpg"
  end
end

class User < ApplicationRecord
  has_many :followers, class_name: "Follow", foreign_key: "followed_id"
  has_many :followings, class_name: "Follow", foreign_key: "follower_id"

  def followers_count
    followers.count
  end

  def following_count
    followings.count
  end
end

class User < ApplicationRecord
  has_many :saved_posts_relationships, class_name: 'SavedPost', foreign_key: 'user_id'
  has_many :saved_posts, through: :saved_posts_relationships, source: :post
end

