class User < ApplicationRecord
  has_secure_password

  has_many :cards
  has_many :incomes
  has_many :random_expense_labels, class_name: 'RandomExpenseLabel'
  has_many :recurrent_expense_labels, class_name: 'RecurrentExpenseLabel'
  has_many :income_labels, class_name: 'IncomeLabel'
  has_many :random_expenses, class_name: 'RandomExpense'
  has_many :recurrent_expenses, class_name: 'RecurrentExpense'
  has_many :days

  def default_currency
    'RUB'
  end
end
