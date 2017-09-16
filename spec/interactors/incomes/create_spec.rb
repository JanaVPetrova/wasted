RSpec.describe Incomes::Create do
  let(:user) { create :user }
  let(:label) { create :income_label, user: user }
  let(:amount_cents) { generate(:integer) * 100 }
  let(:params) do
    {
      amount_cents: amount_cents,
      amount_currency: user.default_currency,
      label_id: label.id
    }
  end

  subject { described_class.call(user: user, params: params) }

  it do
    expect { subject }.to change { user.incomes.count }.by 1
  end
end
