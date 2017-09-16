class Day < ApplicationRecord
  belongs_to :user
  has_many :random_expenses
  has_many :recurrent_expenses

  monetize :limit_amount_cents
end
