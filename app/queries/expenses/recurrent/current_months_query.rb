class Expenses::Recurrent::CurrentMonthsQuery
  attr_reader :user

  def self.call(user:)
    new(user: user).call
  end

  def initialize(user:)
    @user = user
  end

  def call
    user.recurrent_expenses.where(spend_at: (Date.today.beginning_of_month..Date.today.end_of_month))
  end
end
