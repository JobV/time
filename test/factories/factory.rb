FactoryGirl.define do
  factory :timer, class: Timer do
  end

  factory :project, class: Project do
    name 'jx-time'
    association :user, factory: :user
  end

  factory :user, class: User do
    sequence(:email, 1000) {|n| "test#{n}@example.com"}
    password 'test1234'
  end
end
