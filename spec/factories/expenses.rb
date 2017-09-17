FactoryGirl.define do
  factory :expense do
    amount_cents { generate(:integer) * 100 * 100 }
    spend_at { Time.current }
    day
    user
    label { create :recurrent_expense_label }
  end

  factory :recurrent_expense, parent: :expense do
    type 'RecurrentExpense'
  end

  factory :random_expense, parent: :expense do
    type 'RandomExpense'
  end
end
