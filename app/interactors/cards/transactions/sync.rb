class Cards::Transactions::Sync
  include Interactor

  delegate :card, :client, to: :context

  before { context.client ||= Openbank.new }

  def call
    transactions = client.transactions_history(card.external_id, card.synced_at)

    Card.transaction do
      transactions.each do |transaction_data|
        if expense?(transaction_data)
          create_expense(transaction_data)
        elsif income?(transaction_data)
          create_income(transaction_data)
        end
      end

      card.touch(:synced_at)
    end
  end

  private

  def user
    @user ||= card.user
  end

  def expense?(transaction)
    transaction[:amount_cents] < 0
  end

  def create_expense(transaction)
    if recurrent_expense_label(transaction).present?
      label = recurrent_expense_label(transaction)
      create_recurrent_expense(transaction, label)
    else
      label = random_expense_label(transaction)
      create_random_expense(transaction, label)
    end
  end

  def random_expense_label(transaction)
    user.random_expense_labels.where(title: transaction[:title]).first_or_create
  end

  def recurrent_expense_label(transaction)
    user.recurrent_expense_labels.find_by(title: transaction[:title])
  end

  def create_random_expense(transaction, label)
    Expenses::Random::Create.call(
      user: card.user,
      params: {
        amount_cents: -transaction[:amount_cents],
        amount_currency: transaction[:amount_currency],
        label_id: label.id
      }
    )
  end

  def create_recurrent_expense(transaction, label)
    Expenses::Recurrent::Create.call(
      user: card.user,
      params: {
        amount_cents: -transaction[:amount_cents],
        amount_currency: transaction[:amount_currency],
        label_id: label.id
      }
    )
  end

  def income?(transaction)
    transaction[:amount_cents] > 0
  end

  def create_income(transaction)
    label = user.income_labels.where(title: transaction[:title]).first_or_create

    Incomes::Create.call(
      user: card.user,
      params: {
        amount_cents: transaction[:amount_cents],
        amount_currency: transaction[:amount_currency],
        label_id: label.id
      }
    )
  end
end
