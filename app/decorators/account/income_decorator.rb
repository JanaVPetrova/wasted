class Account::IncomeDecorator < Draper::Decorator
  delegate_all

  def prettify
    "#{object.amount.format} #{object.label.title}"
  end
end
