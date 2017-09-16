RSpec.describe Account::ExpensesController do
  render_views

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET index' do
    subject { get :index }

    it { is_expected.to be_success }
  end
end
