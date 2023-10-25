class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'

  def recent_posts
    self.posts.order(created_at: :desc).limit(3)
  end

  def post_count
    posts.count
  end
end
