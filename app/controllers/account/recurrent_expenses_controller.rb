class Account::RecurrentExpensesController < Account::ApplicationController
  def index
    @recurrent_expences = Account::ExpenseDecorator.decorate_collection(
      Expenses::Recurrent::CurrentMonthsQuery.call(user: current_user)
    )
    @today = Users::TodayQuery.call(user: current_user)
    @labels = current_user.recurrent_expense_labels
    @expense = current_user.recurrent_expenses.build
  end

  def create
    result = Expenses::Recurrent::Create.call(
      expense_params.merge(user: current_user)
    )

    if result.success?
      redirect_to account_recurrent_expenses_path
    else
      @expense = result.expense
      @recurrent_expences = Account::ExpenseDecorator.decorate_collection(
        Expenses::Recurrent::CurrentMonthsQuery.call(user: current_user)
      )
      @labels = current_user.recurrent_expense_labels

      flash[:error] = @expense.errors.full_messages.join("\n")

      render :index
    end
  end

  def edit
    @expense = current_user.recurrent_expenses.find(params[:id])
    @labels = current_user.recurrent_expense_labels
  end

  def update
    @expense = current_user.recurrent_expenses.find(params[:id])
    result = Expenses::Recurrent::Update.call(expense: @expense, params: expense_params)

    if result.success?
      redirect_to account_recurrent_expenses_path
    else
      @expense = result.expense
      @labels = current_user.recurrent_expense_labels

      flash[:error] = @expense.errors.full_messages.join("\n")

      render :edit
    end
  end

  def destroy
  end

  private

  def expense_params
    params.require(:recurrent_expense).permit(:label_id, :amount_cents, :amount_currency)
  end
end
