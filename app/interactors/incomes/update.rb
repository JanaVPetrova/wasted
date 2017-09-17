class Incomes::Update
  include Interactor

  delegate :income, :params, to: :context

  def call
    Income.transaction do
      income.update(params)

      context.fail! if income.errors.any?

      update_daily_limits!
    end
  end

  private

  def update_daily_limits!
    Days::UpdateLimit.call(user: income.user, date: Time.current)
  end
end
