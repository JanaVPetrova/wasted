class Account::DayDecorator < Draper::Decorator
  delegate_all

  def saldo
    (object.limit_amount - object.random_expenses.sum(&:amount)).format
  end

  def wasted
    if object.random_expenses.any?
      object.random_expenses.sum(&:amount)
    else
      Money.new(0, object.user.default_currency)
    end
  end
end
