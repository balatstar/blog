require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  let(:user) { create(:user) }
  let!(:posts) { create_list(:post, 5, author: user) }
  let!(:first_3_posts) { user.recent_posts.limit(3) }

  before do
    visit user_path(user)
  end

  scenario 'displays the user profile picture' do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  scenario 'displays the user username' do
    expect(page).to have_content(user.name)
  end

  scenario 'displays the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  scenario 'displays the user bio' do
    expect(page).to have_content(user.bio)
  end

  scenario 'displays the user\'s first 3 posts' do
    first_3_posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
      expect(page).to have_content("Comments: #{post.comments_counter}, Likes: #{post.likes_counter}")
    end
  end

  scenario 'can view a user\'s post by clicking on it' do
    first_3_posts.each do |post|
      click_link post.title
      expect(page).to have_current_path(user_post_path(user, post))
      visit user_path(user)
    end
  end

  scenario 'can view all user posts' do
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
