RSpec.describe Cards::Transactions::Sync do
  let(:card) { create :card }
  let(:transactions) do
    [
      {
        date: Time.parse('20.07.2017'),
        title: 'Перечисление з/п по реестру',
        amount_cents: 5000000.0,
        amount_currency: 'RUB'
      },
      {
        date: Time.parse('02.08.2017'),
        title: 'банкомат ФК Открытие',
        amount_cents: -500000.0,
        amount_currency: 'RUB'
      },
      {
        date: Time.parse('01.08.2017'),
        title: 'АЗС Лукойл 101',
        amount_cents: -150000.0,
        amount_currency: 'RUB'
      }
    ]
  end
  let(:user) { card.user }
  let(:client) { double('openbank_client', transactions_history: transactions) }

  subject { described_class.call(card: card, client: client) }

  before do
    create :recurrent_expense_label, user: user, title: 'банкомат ФК Открытие'
  end

  it 'updates user expenses and incomes' do
    subject

    expect(user.recurrent_expenses.count).to eq 1
    expect(user.random_expenses.count).to eq 1
    expect(user.incomes.count).to eq 1
  end
end
