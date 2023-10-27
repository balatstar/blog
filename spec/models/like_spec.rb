require 'rails_helper'

RSpec.describe Like, type: :model do
  it "increments the post's likes_counter after create" do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.create(title: 'Sample Title', author: user)
    like = Like.create(user:, post:)
    expect(post.reload.likes_counter).to eq(1)
  end

  it "decrements the post's likes_counter after destroy" do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.create(title: 'Sample Title', author: user)
    like = Like.create(user:, post:)
    like.destroy
    expect(post.reload.likes_counter).to eq(0)
  end
end
