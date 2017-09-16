RSpec.describe Cards::Sync do
  let(:user) { create :user }
  let(:cards_list) do
    [
      { title: 'Кредитная', external_id: '31337', kind: 'credit', payment_system: 'visa' },
      { title: 'Дебетовая', external_id: '42', kind: 'debit', payment_system: 'mir' }
    ]
  end
  let(:external_ids) { cards_list.map { |card| card[:external_id] } }
  let(:client) { double('openbank_client', cards_list: cards_list) }
  subject { described_class.call(user: user, client: client) }

  it 'updates user cards' do
    subject

    expect(user.cards.where(external_id: external_ids).count).to eq(cards_list.count)
  end
end
