require 'rails_helper'

RSpec.feature 'User Post Index Page', type: :feature do
  before do
    @user = create(:user)
    @posts = create_list(:post, 10, author: @user)
    visit user_posts_path(@user)
  end

  context 'User Information Display' do
    scenario 'displays user profile picture' do
      expect(page).to have_css("img[src*='#{@user.photo}']")
    end

    scenario 'displays user username' do
      expect(page).to have_content(@user.name)
    end

    scenario 'displays number of user posts' do
      expect(page).to have_content('All Posts')
      expect(page).to have_content("Number of posts: #{@user.posts_counter}")
    end
  end

  context 'Post Content Display' do
    scenario 'displays post title and body' do
      latest_posts = @user.posts.order(created_at: :asc).limit(5)
      latest_posts.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.text)
      end
    end

    scenario 'displays first comments on posts and the total comment count' do
      @posts.each do |post|
        post.comments.order(created_at: :desc).first
        expect(page).to have_content('Comment from user')
        expect(page).to have_content("Comments: #{post.comments_counter.to_i}")
      end
    end

    scenario 'displays the number of likes on posts' do
      @posts.each do |post|
        expect(page).to have_content("Likes: #{post.likes_counter.to_i}")
      end
    end
  end

  context 'Navigation' do
    scenario 'displays pagination' do
      pagination_element = find('.pagination', visible: true)
      expect(pagination_element).to have_content('Next')
    end

    scenario 'clicking on a post redirects to its show page' do
      post = @posts.first
      click_link post.title
      expect(current_path).to eq(user_post_path(@user, post))
    end
  end
end
