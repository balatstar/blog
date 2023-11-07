FactoryBot.define do
  factory :comment do
    sequence(:text) { |n| "Comment from user #{n}" }
    association :user
    association :post
  end
end