FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    photo { 'https://unsplash.com/photos/F_-0BxGuVvo' }
    sequence(:bio) { |n| "This is the bio for User #{n}" }
  end

  factory :user_with_posts, parent: :user do
    transient do
      posts_count { 5 }
    end

    after(:create) do |user, evaluator|
      create_list(:post, evaluator.posts_count, user:)
    end
  end
end
