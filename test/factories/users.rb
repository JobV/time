# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence {|n| "#{n}_user@gmail.com" }
  end
end
