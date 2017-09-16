FactoryGirl.define do
  factory :income_label do
    title { generate :string }
    user
  end

  factory :random_expense_label, parent: :income_label do
  end

  factory :recurrent_expense_label, parent: :income_label do
  end
end
