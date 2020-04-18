FactoryBot.define do
  factory :user, aliases: [:friend] do
    username      { FFaker::Name.unique.first_name }
    password      { 'password' }
  end
end
