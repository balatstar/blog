require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name and posts_counter >= 0' do
    user = User.new(name: 'Roy Batty', posts_counter: 5)
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(name: nil, posts_counter: 5)
    expect(user).not_to be_valid
  end

  it 'is not valid with a non-integer posts_counter' do
    user = User.new(name: 'Roy Batty', posts_counter: 5.5)
    expect(user).not_to be_valid
  end

  it 'is not valid with a negative posts_counter' do
    user = User.new(name: 'Roy Batty', posts_counter: -1)
    expect(user).not_to be_valid
  end

  describe '#recent_posts' do
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'Roy Batty', posts_counter: 5)

      user.posts.create(title: 'Post 0', created_at: 3.days.ago)
      post2 = user.posts.create(title: 'Post 1', created_at: 2.days.ago)
      post3 = user.posts.create(title: 'Post 2', created_at: 1.day.ago)
      post4 = user.posts.create(title: 'Post 3', created_at: Time.current)
      user.posts.create(title: 'Post 4', created_at: 4.days.ago)
      recent_posts = [post4, post3, post2]

      expect(user.recent_posts).to eq(recent_posts)
    end
  end

  describe '#post_count' do
    it 'returns the number of posts' do
      user = User.create(name: 'Roy Batty', posts_counter: 5)
      5.times do |i|
        user.posts.create(title: "Post #{i}")
      end

      expect(user.post_count).to eq(5)
    end
  end
end
