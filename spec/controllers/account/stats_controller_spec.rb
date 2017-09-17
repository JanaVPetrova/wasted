RSpec.describe Account::CardsController do
  render_views

  let(:user) { create :user, :with_incomes, :with_recurrent_expenses }
  before { sign_in user }

  describe 'GET index' do
    subject { get :index }

    it { is_expected.to be_success }
  end
end
