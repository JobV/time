FactoryGirl.define do

  factory :moment do
    created_at Time.parse("12:00")

    factory :ended_moment do
      end_time Time.parse("13:00")
    end

    timer
  end

  factory :timer do

    factory :timer_with_moments do 
      ignore do
        moments_count 5
      end
      after(:create) do |timer, evaluator|
        FactoryGirl.create_list(:ended_moment, evaluator.moments_count, timer: timer)
      end
    end
  end
end
