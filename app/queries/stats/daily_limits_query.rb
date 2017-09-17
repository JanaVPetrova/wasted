class Stats::DailyLimitsQuery
  attr_reader :user

  def self.call(user:)
    new(user: user).call
  end

  def initialize(user:)
    @user = user
  end

  def call
    user.days.where(date: current_month).order(date: :asc).each_with_object({}) do |day, memo|
      memo[day.date] = day.limit_amount_cents / day.limit_amount.currency.subunit_to_unit
    end
  end

  private

  def current_month
    (Date.today.beginning_of_month..Date.today.end_of_month)
  end
end
