class Account::RandomExpensesController < Account::ApplicationController
  def index
    @today = Account::DayDecorator.decorate(Users::TodayQuery.call(user: current_user))
    @random_expences = Account::ExpenseDecorator.decorate_collection(
      Expenses::Random::TodaysQuery.call(user: current_user)
    )
    @labels = current_user.random_expense_labels
    @expense = current_user.random_expenses.build
  end

  def create
    result = Expenses::Random::Create.call(
      expense_params.merge(user: current_user)
    )

    if result.success?
      redirect_to account_random_expenses_path
    else
      @today = Account::DayDecorator.decorate(Users::TodayQuery.call(user: current_user))
      @expense = result.expense
      @random_expences = Account::ExpenseDecorator.decorate_collection(
        Expenses::Random::TodaysQuery.call(user: current_user)
      )
      @labels = current_user.random_expense_labels

      flash[:error] = @expense.errors.full_messages.join("\n")

      render :index
    end
  end

  def update
  end

  def destroy
  end

  private

  def expense_params
    params.require(:random_expense).permit(:id, :label_id, :amount_cents, :amount_currency)
  end
end
