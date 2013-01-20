FactoryGirl.define do
  factory :language do
    sequence :name do |n|
      "prog lang #{n}"
    end
  end
end