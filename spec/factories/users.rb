FactoryBot.define do
  factory :user do
    name {"new_user"}
    sequence(:email) { |n| "test#{n}@example.com" }
    password {"password"}
    password_confirmation {"password"}
    role {"user"}
  end
end
