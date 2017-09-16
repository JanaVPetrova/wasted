class Expenses::Recurrent::Update
  include Interactor

  delegate :expense, :params, to: :context

  def call
    RecurrentExpense.transaction do
      context.expense ||= user.recurrent_expenses.find(id)
      expense.update(params)

      context.fail! if expense.errors.any?

      update_daily_limits!
    end
  end

  private

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
    Days::UpdateLimit.call(user: expense.user, date: spend_at)
  end
end
