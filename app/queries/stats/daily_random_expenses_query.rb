class Stats::DailyRandomExpensesQuery
  attr_reader :user

  def self.call(user:)
    new(user: user).call
  end

  def initialize(user:)
    @user = user
  end

  def call
    days.each_with_object({}) do |day, memo|
      amount = make_money(day.random_expenses.sum(&:amount), day)
      memo[day.date] = amount.cents / amount.currency.subunit_to_unit
    end
  end

  private

  def days
    @days ||= user.days.includes(:random_expenses).where(date: current_month).order(date: :asc)
  end

  def make_money(amount, day)
    amount.kind_of?(Money) ? amount : Money.new(amount, day.limit_amount_currency)
  end

  def current_month
    (Date.today.beginning_of_month..Date.today.end_of_month)
  end
end
