FactoryGirl.define do
  factory :income do
    user
    label { create :income_label }
    amount_cents { generate(:integer) * 100 }
    received_at { Time.current.beginning_of_month }
    spend_till { Time.current.end_of_month }
  end
end
