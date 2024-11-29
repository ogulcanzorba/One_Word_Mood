class Post < ApplicationRecord
  belongs_to :user
  validates :mood_word, presence: true, format: { with: /\A\w+\z/, message: "must be a single word" }
end
