class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_likes_counter(increment) # increment = true if adding new like, = false if deleting like
    post.update(likes_counter: post.likes_counter + (increment ? 1 : -1))
  end
end
