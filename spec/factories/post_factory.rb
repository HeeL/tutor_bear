FactoryGirl.define do
  factory :post do
    title 'title'
    desc 'description'
    text 'text'
    published_at Date.today
  end
end