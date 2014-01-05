# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) {|n| "#{n}_user@gmail.com" }

  factory :user do
    email
    password 'asimplepassword'
    password_confirmation 'asimplepassword'

    factory :admin do
      admin true
    end

  end
end
