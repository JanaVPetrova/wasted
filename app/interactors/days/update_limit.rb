class Days::UpdateLimit
  include Interactor

  delegate :user, :date, to: :context

  before { context.date = context.date.to_date }

  def call
    update_limits
  end

  private

  def update_limits
    month.each.with_index do |date, index|
      yesterdays_amount = if index == 0
        Money.new(0, daily_limit.currency.iso_code)
      else
        yesterday = user.days.where(date: date - 1.day).first_or_create!
        yesterday.limit_amount - yesterday.random_expenses.sum(&:amount)
      end

      today = user.days.where(date: date).first_or_create!
      amount = daily_limit + yesterdays_amount
      update_daily_limit(today, amount)
    end

    user.days.where(date: month)
  end

  def update_daily_limit(day, amount)
    day.update!(limit_amount: amount)
  end

  def incomes
    @incomes ||= user.incomes.where(received_at: month)
  end

  def recurrent_expenses
    @recurrent_expenses ||= user.recurrent_expenses.where(spend_at: month)
  end

  def total_expenses
    @total_expenses ||= recurrent_expenses.sum(&:amount)
  end

  def total_incomes
    @total_incomes ||= incomes.sum(&:amount)
  end

  def daily_limit
    @daily_limit ||= (total_incomes - total_expenses) / month.count
  end

  def month
    (date.beginning_of_month..date.end_of_month)
  end
end
