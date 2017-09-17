class Account::StatsController < Account::ApplicationController
  def index
    @assistent_message = Assistent.new(type: current_user.assistent).wants_to_say
    @days = Stats::DailyLimitsQuery.call(user: current_user)
    @random_expenses_daily = Stats::DailyRandomExpensesQuery.call(user: current_user)
    @random_expenses_by_label = Stats::GroupedRandomExpensesQuery.call(user: current_user)
    @recurrent_expenses_by_label = Stats::GroupedRecurrentExpensesQuery.call(user: current_user)
  end
end
