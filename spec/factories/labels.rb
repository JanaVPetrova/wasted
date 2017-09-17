FactoryGirl.define do
  factory :income_label do
    title { generate :string }
    type 'IncomeLabel'
    user
    category
  end

  factory :random_expense_label, parent: :income_label do
    type 'RandomExpenseLabel'
  end

  factory :recurrent_expense_label, parent: :income_label do
    type 'RecurrentExpenseLabel'
  end
end
