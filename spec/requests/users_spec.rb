require 'rails_helper'
include Rails.application.routes.url_helpers

RSpec.describe 'Users', type: :request do
  describe 'GET /' do
    it 'returns correct response status, placeholder, template for /' do
      get root_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('<h1>Users</h1>')
    end
  end

  describe 'GET /users/:user_id' do
    it 'returns correct response status, placeholder, template for /users/:user_id' do
      user = User.create(name: 'Ash Ketchum', id: 1)
      get user_path(user.id)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include('<h1>User Details</h1>')
    end
  end
end
