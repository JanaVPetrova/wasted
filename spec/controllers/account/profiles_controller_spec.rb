RSpec.describe Account::ProfilesController do
  render_views

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET show' do
    subject { get :show }

    it { is_expected.to be_success }
  end

  describe 'PATCH update' do
    let(:kirpich) { 'kirpich' }
    let(:params) { { user: { assistent: kirpich } } }
    subject { patch :update, params: params }

    it 'updated user' do
      is_expected.to be_redirect
      expect(user.reload.assistent).to eq kirpich
    end
  end
end
