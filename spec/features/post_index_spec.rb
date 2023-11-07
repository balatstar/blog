require 'rails_helper'

RSpec.feature 'User Post Index Page', type: :feature do
  before do
    @user = create(:user)
    @posts = create_list(:post, 10, author: @user)
    visit user_posts_path(@user)
  end

  scenario 'displays user profile picture' do
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  scenario 'displays user username' do
    expect(page).to have_content(@user.name)
  end

  scenario 'displays number of user posts' do
    expect(page).to have_content('All Posts')
    expect(page).to have_selector('.user-post', count: @posts.size)
  end

  scenario 'displays post title and body' do
    @posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  scenario 'displays first comments on posts and the total comment count' do
    @posts.each do |post|
      expect(page).to have_content(post.recent_comments.first.text)
      expect(page).to have_content("Comments: #{post.comments_counter.to_i}")
    end
  end

  scenario 'displays the number of likes on posts' do
    @posts.each do |post|
      expect(page).to have_content("Likes: #{post.likes_counter.to_i}")
    end
  end

  scenario 'displays pagination' do
    expect(page).to have_selector('.post-pagination')
  end

  scenario 'clicking on a post redirects to its show page' do
    post = @posts.first
    click_link post.title
    expect(current_path).to eq(user_post_path(@user, post))
  end
end
