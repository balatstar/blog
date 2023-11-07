require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  before do
    @users = create_list(:user, 5)
    @users.each do |user|
      create_list(:post, 5, author: user)
    end
    visit root_path
  end

  scenario 'displays usernames of all other users' do
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  scenario 'displays profile pictures for each user' do
    @users.each do |user|
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
  end

  scenario 'displays the number of posts each user has written' do
    @users.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter.to_i}")
    end
  end

  scenario 'user links to user show page' do
    @users.each do |user|
      within(".user-container") do
        expect(page).to have_link(user.name, href: user_path(user))
      end
    end
  end
end
