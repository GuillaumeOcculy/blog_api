FactoryBot.define do
  factory :post, aliases: [:commentable, :likeable] do
    body      { FFaker::Lorem.paragraph }

    association :user
  end
end
