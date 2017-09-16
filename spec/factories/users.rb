FactoryGirl.define do
  factory :user do
    name { generate :name }
    email { generate :email }
    password { generate :string }

    trait :with_incomes do
      after(:create) do |user, evaluator|
        create :income, user: user
        create :day, user: user
      end
    end
  end
end
