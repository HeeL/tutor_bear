FactoryGirl.define do
  factory :post do
    title 'title'
    desc 'description'
    text 'text'
    published_at 2.days.ago
  end
end