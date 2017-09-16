class Income < ApplicationRecord
  belongs_to :user
  belongs_to :label, class_name: 'IncomeLabel'

  monetize :amount_cents
end
