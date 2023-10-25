class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments

  def update_posts_counter(increment) # increment = true if adding new post, = false if deleting post
    author.update(posts_counter: author.posts_counter + (increment ? 1 : -1))
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
