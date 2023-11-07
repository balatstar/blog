require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
  before do
    @post = create(:post)
    visit user_post_path(@post.author, @post)
  end

  scenario 'displays post title' do
    expect(page).to have_content(@post.title)
  end

  scenario 'displays the author of the post' do
    expect(page).to have_content("by #{@post.author.name}")
  end

  scenario 'displays the number of comments on the post' do
    expect(page).to have_content("Comments: #{@post.comments_counter.to_i}")
  end

  scenario 'displays the number of likes on the post' do
    expect(page).to have_content("Likes: #{@post.likes_counter.to_i}")
  end

  scenario 'displays the post body' do
    expect(page).to have_content(@post.text)
  end

  scenario 'displays username and comments for each commentor' do
    @post.comments.each do |comment|
      expect(page).to have_content("#{comment.user.name}: #{comment.text}")
    end
  end
end
