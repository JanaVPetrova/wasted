FactoryGirl.define do
  factory :card do
    user
    title { generate :name }
    external_id { generate(:integer).to_s }
    kind { generate :string }
    payment_system { generate :string }
    synced_at { Time.current }
  end
end
