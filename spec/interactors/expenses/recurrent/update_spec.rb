RSpec.describe Expenses::Recurrent::Update do
  let(:user) { create :user, :with_incomes }
  let(:expense) { create :recurrent_expense, user: user }
  let(:amount_cents) { generate(:integer) * 100 }
  let(:params) { { amount_cents: amount_cents } }

  subject { described_class.call(expense: expense, params: params) }

  it do
    expect { subject }.to change { expense.amount_cents }.to amount_cents
  end
end
