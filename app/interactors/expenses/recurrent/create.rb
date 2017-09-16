class Expenses::Recurrent::Create
  include Interactor

  delegate :user, :amount_cents, :amount_currency, :label_id, to: :context
  delegate :expense, to: :context

  before { context.fail!(error: 'no money, no honey') if day.blank? }

  def call
    RecurrentExpense.transaction do
      context.expense = create_expense

      context.fail! if expense.errors.any?

      update_daily_limits!
    end
  end

  private

  def create_expense
    day.recurrent_expenses.create(
      amount_cents: amount_cents,
      amount_currency: currency,
      user: user,
      label_id: label_id,
      spend_at: spend_at
    )
  end

  def day
    @day ||= user.days.find_by(date: spend_at.to_date)
  end

  def currency
    amount_currency || user.default_currency
  end

  def spend_at
    Time.current
  end

  def update_daily_limits!
    Days::UpdateLimit.call(user: user, date: spend_at)
  end
end
