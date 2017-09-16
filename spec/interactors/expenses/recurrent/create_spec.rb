RSpec.describe Expenses::Recurrent::Create do
  let(:amount_currency) { 'RUB' }
  let(:amount_cents) { 10000 }
  let(:user) { create :user, :with_incomes }
  let(:label) { create :recurrent_expense_label }

  subject do
    described_class.call(
      user: user,
      params: {
        amount_cents: amount_cents,
        amount_currency: amount_currency,
        label_id: label.id
      }
    )
  end

  it 'creates recurrent expense' do
    expect { subject }.to change { user.recurrent_expenses.count }.by 1
  end
end
