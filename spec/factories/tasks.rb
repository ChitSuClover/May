FactoryBot.define do
  factory :task do
    association :user
    title { 'test_title' }
    content { 'test_content' }
    expired_at {Time.current+2.days}
    status {'unstarted'}
    pripority {'low'}
  end
end
