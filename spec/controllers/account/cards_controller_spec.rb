RSpec.describe Account::CardsController do
  render_views

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET index' do
    subject { get :index }

    it { is_expected.to be_success }
  end

  describe 'POST sync' do
    let(:sync_result) { double('card-sync', success?: true) }
    before { allow(Cards::Sync).to receive(:call).and_return(sync_result) }

    subject { post :sync }

    it { is_expected.to be_redirect }
  end
end
