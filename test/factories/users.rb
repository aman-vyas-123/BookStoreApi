FactoryBot.define do
  factory :user do
    password { 'password123' }
    email { Faker::Internet.email }
    name {Faker::Internet.name}
  end
end
