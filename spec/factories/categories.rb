FactoryGirl.define do
  factory :category do
    title { generate :name }
  end
end
