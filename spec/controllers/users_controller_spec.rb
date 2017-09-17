require 'rails_helper'

RSpec.describe UsersController do
  render_views

  describe 'GET new' do
    subject { get :new }

    it { is_expected.to be_success }
  end

  describe 'POST create' do
    let(:params) { attributes_for(:user) }

    subject { post :create, params: { user: params } }

    it 'signs in user' do
      is_expected.to be_redirect
      expect(current_user.email).to eq params[:email]
    end
  end
end
