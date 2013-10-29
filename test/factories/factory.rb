FactoryGirl.define do
  factory :timer do
  end

  factory :user do
    sequence(:email, 1000) {|n| "test#{n}@example.com"}
    password 'test1234'
  end
end
