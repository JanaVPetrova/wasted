class Incomes::Create
  include Interactor

  delegate :user, :params, to: :context
  delegate :income, to: :context

  def call
    Income.transaction do
      context.income = create_income
      context.fail! if income.errors.any?

      update_daily_limits!
    end
  end

  private

  def create_income
    user.incomes.create(income_params)
  end

  def currency
    params[:amount_currency] || user.default_currency
  end

  def received_at
    @received_at ||= Time.current.beginning_of_month
  end

  def update_daily_limits!
    Days::UpdateLimit.call(user: user, date: received_at)
  end

  def income_params
    params.merge(
      received_at: received_at,
      spend_till: received_at.end_of_month,
      amount_currency: currency
    )
  end
end
