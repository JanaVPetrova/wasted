RSpec.describe Days::UpdateLimit do
  let(:user) { create :user, :with_incomes, :with_recurrent_expenses }
  let(:date) { Date.today }
  let(:limits_sum) { user.days.sum(&:limit_amount) }
  let(:available_sum) { user.incomes.sum(&:amount) - user.recurrent_expenses.sum(&:amount) }
  let(:delta) { Money.new(100, user.default_currency) }

  subject { described_class.call(user: user, date: date) }

  it 'updates daily limits for month' do
    subject

    expect(user.days.count).to eq(Time.days_in_month(date.month, date.year))
    expect(limits_sum).to be_within(delta).of(available_sum)
  end
end
