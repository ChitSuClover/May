FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    expired_at {Time.current+1.days}
  end
end
