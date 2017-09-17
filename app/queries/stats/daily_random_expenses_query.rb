class Stats::DailyRandomExpensesQuery
  attr_reader :user

  def self.call(user:)
    new(user: user).call
  end

  def initialize(user:)
    @user = user
  end

  def call
    user.days.where(date: current_month).order(date: :asc).each_with_object({}) do |day, memo|
      amount = if day.random_expenses.any?
        day.random_expenses.sum(&:amount)
      else
        Money.new(0, day.limit_amount_currency)
      end
      memo[day.date] = amount.cents / amount.currency.subunit_to_unit
    end
  end

  private

  def current_month
    (Date.today.beginning_of_month..Date.today.end_of_month)
  end
end
