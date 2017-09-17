RSpec.describe Account::Cards::TransactionsController do
  render_views

  let(:card) { create :card }
  let(:user) { card.user }
  before { sign_in user }

  describe 'POST sync' do
    let(:sync_result) { double('card-transactions-sync', success?: true) }
    before { allow(Cards::Transactions::Sync).to receive(:call).and_return(sync_result) }

    subject { post :sync, params: { card_id: card.id  } }

    it { is_expected.to be_redirect }
  end
end
