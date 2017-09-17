class Expenses::Random::Update
  include Interactor

  delegate :expense, :params, to: :context

  def call
    RandomExpense.transaction do
      expense.update(params)

      context.fail! if expense.errors.any?
    end
  end
end
