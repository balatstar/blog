require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "increments the post's comments_counter after create" do
    user = User.create(name: "Roy Batty", posts_counter: 5)
    post = Post.create(title: "Sample Title", author: user)
    comment = Comment.create(user: user, post: post)
    expect(post.reload.comments_counter).to eq(1)
  end

  it "decrements the post's comments_counter after destroy" do
    user = User.create(name: "Roy Batty", posts_counter: 5)
    post = Post.create(title: "Sample Title", author: user)
    comment = Comment.create(user: user, post: post)
    comment.destroy
    expect(post.reload.comments_counter).to eq(0)
  end
end
