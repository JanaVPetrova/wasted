class Account::StatsController < Account::ApplicationController
  def index
    @days = Users::MonthsQuery.call(user: current_user)
    @random_expenses_by_label = current_user.random_expenses.each_with_object({}) do |expense, memo|
      memo[expense.label.title] ||= 0
      memo[expense.label.title] += expense.amount_cents / expense.amount.currency.subunit_to_unit
    end
    @recurrent_expenses_by_label = current_user.recurrent_expenses.each_with_object({}) do |expense, memo|
      memo[expense.label.title] ||= 0
      memo[expense.label.title] += expense.amount_cents / expense.amount.currency.subunit_to_unit
    end
  end
end
