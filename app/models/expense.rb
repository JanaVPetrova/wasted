class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :label
  belongs_to :day

  monetize :amount_cents
end
