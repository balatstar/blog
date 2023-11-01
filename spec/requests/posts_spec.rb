require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    it 'returns correct response status, placeholder, template for /users/:user_id/posts' do
      user = User.create(name: 'Name', posts_counter: 0)
      get user_posts_path(user_id: user.id)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Here are all of the posts from User')
      expect(response).to render_template(:index)
    end
  end

  describe '/users/:user_id/posts/:id' do
    it 'returns correct response status, placeholder, template for /users/:user_id/posts/:id' do
      user = User.create(name: 'Name', posts_counter: 0)
      post = Post.create(title: 'Post Title', author_id: user.id, comments_counter: 0, likes_counter: 0)
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Here is the full post')
      expect(response).to render_template(:show)
    end
  end
end
