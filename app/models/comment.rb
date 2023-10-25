class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_save :update_comments_counter

  def update_comments_counter(increment) # increment = true if adding new comment, = false if deleting comment
    post.update(comments_counter: post.comments_counter + (increment ? 1 : -1))
  end
end
