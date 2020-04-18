FactoryBot.define do
  factory :comment do
    body      { FFaker::Lorem.paragraph }

    association :commentable
    association :user
  end
end
