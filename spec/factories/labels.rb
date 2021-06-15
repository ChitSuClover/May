FactoryBot.define do
  factory :label do
    association :user
    name { 'label_test' }
  end
end
