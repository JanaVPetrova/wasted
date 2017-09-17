class Stats::GroupedRandomExpensesQuery
  attr_reader :user

  def self.call(user:)
    new(user: user).call
  end

  def initialize(user:)
    @user = user
  end

  def call
    user.random_expenses.where(day_id: days.ids).each_with_object({}) do |expense, memo|
      memo[expense.label.title] ||= 0
      memo[expense.label.title] += expense.amount_cents / expense.amount.currency.subunit_to_unit
    end
  end

  private

  def days
    user.days.where(date: current_month)
  end

  def current_month
    (Date.today.beginning_of_month..Date.today.end_of_month)
  end
end
