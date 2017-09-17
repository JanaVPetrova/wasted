require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  render_views

  describe 'GET new' do
    subject { get :new }

    it { is_expected.to be_success }
  end

  describe 'POST create' do
    let(:password) { generate :string }
    let(:user) { create :user, password: password }

    subject { post :create, params: { session: { email: user.email, password: password } } }

    it 'signs in user' do
      is_expected.to be_redirect
      expect(current_user).to eq user
    end
  end
end
