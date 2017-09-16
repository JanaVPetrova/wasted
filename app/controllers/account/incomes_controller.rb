class Account::IncomesController < Account::ApplicationController
  def index
    @income = current_user.incomes.build
    @incomes = Account::IncomeDecorator.decorate_collection(
        Incomes::CurrentMonthsQuery.call(user: current_user)
      )
    @labels = current_user.income_labels
  end

  def create
    result = Incomes::Create.call(
      user: current_user,
      params: income_params
    )

    if result.success?
      redirect_to account_incomes_path
    else
      @income = result.income
      @incomes = Account::IncomeDecorator.decorate_collection(
        Incomes::CurrentMonthsQuery.call(user: current_user)
      )
      @labels = current_user.income_labels

      flash[:error] = @income.errors.full_messages.join("\n")

      render :index
    end
  end

  def update
    @income = current_user.incomes.find_by(id: params[:id])

    if @income.update(income_params)
      redirect_to account_incomes_path
    else
      render :edit
    end
  end

  def destroy
    current_user.incomes.destroy

    redirect_to account_incomes_path
  end

  private

  def income_params
    params.require(:income).permit(
      :id,
      :label_id,
      :amount_cents,
      :amount_currency,
      :received_at,
      :spend_till
    )
  end
end
