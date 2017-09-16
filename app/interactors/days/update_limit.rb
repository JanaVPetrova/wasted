class Days::UpdateLimit
  include Interactor

  delegate :user, :date, to: :context

  before { context.date = context.date.to_date }

  def call
    days.update_all(
      limit_amount_cents: daily_limit.cents,
      limit_amount_currency: daily_limit.currency.iso_code,
    )
  end

  private

  def days
    month.each do |day|
      user.days.where(date: day).first_or_create!
    end

    user.days.where(date: month)
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
