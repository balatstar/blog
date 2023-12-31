require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with a title' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.new(title: 'Valid Title', author: user)
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.new(author: user)
    expect(post).not_to be_valid
  end

  it 'is not valid with a title > 250 characters' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.new(title: 'A' * 251, author: user)
    expect(post).not_to be_valid
  end

  it 'increments posts_counter after create' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    Post.create(title: 'Sample Title', author: user)
    expect(user.reload.posts_counter).to eq(6)
  end

  it 'decrements posts_counter after destroy' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.create(title: 'Sample Title', author: user)
    post.destroy
    expect(user.reload.posts_counter).to eq(5)
  end

  it 'returns the 5 most recent comments' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.create(title: 'Sample Title', author: user)
    comments = (1..10).map { |i| Comment.create(text: "Comment #{i}", user:, post:) }
    recent_comments = post.recent_comments
    expect(recent_comments).to eq(comments.last(5).reverse)
  end

  it 'is valid with a comments_counter >= 0' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.new(title: 'Sample Title', author: user, comments_counter: 2)
    expect(post).to be_valid
  end

  it 'is not valid with a non-integer comments_counter' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.new(title: 'Sample Title', author: user, comments_counter: 2.5)
    expect(post).not_to be_valid
  end

  it 'is not valid with a negative comments_counter' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.new(title: 'Sample Title', author: user, comments_counter: -1)
    expect(post).not_to be_valid
  end

  it 'is valid with a likes_counter >= 0' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.new(title: 'Sample Title', author: user, likes_counter: 2)
    expect(post).to be_valid
  end

  it 'is not valid with a non-integer likes_counter' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.new(title: 'Sample Title', author: user, likes_counter: 2.5)
    expect(post).not_to be_valid
  end

  it 'is not valid with a negative likes_counter' do
    user = User.create(name: 'Roy Batty', posts_counter: 5)
    post = Post.new(title: 'Sample Title', author: user, likes_counter: -1)
    expect(post).not_to be_valid
  end
end
