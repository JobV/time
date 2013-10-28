FactoryGirl.define do
  factory :timer do
  end

  factory :user do
    email 'test@example.com'
    password 'test1234'
  end
end
