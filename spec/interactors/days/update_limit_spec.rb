RSpec.describe Days::UpdateLimit do
  let(:user) { create :user }
  let!(:recurrent_expense) { create :recurrent_expense, user: user }
  let!(:income) { create :income, user: user }
  let(:date) { Date.today }
  let(:last_day_limit) { user.days.order(date: :desc).first.limit_amount }
  let(:available_sum) { user.incomes.sum(&:amount) - user.recurrent_expenses.sum(&:amount) }
  let(:delta) { Money.new(100, user.default_currency) }

  subject { described_class.call(user: user, date: date) }

  it 'updates daily limits for month' do
    subject

    expect(user.days.count).to eq(Time.days_in_month(date.month, date.year))
    expect(last_day_limit).to be_within(delta).of(available_sum)
  end
end
