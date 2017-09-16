RSpec.describe Expenses::Random::Create do
  let(:amount_currency) { 'RUB' }
  let(:amount_cents) { 10000 }
  let(:user) { create :user, :with_incomes }
  let(:label) { create :random_expense_label }
  let(:today) { Users::TodayQuery.call(user: user) }

  subject do
    described_class.call(
      user: user,
      amount_cents: amount_cents,
      amount_currency: amount_currency,
      label_id: label.id
    )
  end

  it 'creates random expense' do
    expect { subject }.to change { today.random_expenses.count }.by 1
  end
end
