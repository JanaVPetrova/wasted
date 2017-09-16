FactoryGirl.define do
  factory :day do
    date { Date.today }
    limit_amount_cents { generate(:integer) * 100 }
    user
  end
end
