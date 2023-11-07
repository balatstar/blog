FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    text { 'This is the content of the post.' }
    association :author, factory: :user

    transient do
      users_with_comments_and_likes { 1 }
    end

    after(:create) do |post, evaluator|
      evaluator.users_with_comments_and_likes.times do
        user = FactoryBot.create(:user)
        FactoryBot.create(:comment, user:, post:)
        FactoryBot.create(:like, user:, post:)
      end
    end
  end
end
