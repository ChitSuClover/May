FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    expired_at {'2021.6.7'}
  end
  factory :task_order do
    title { 'test_title' }
    content { 'test_content' }
    expired_at {'2021.6.1'}
  end
end
