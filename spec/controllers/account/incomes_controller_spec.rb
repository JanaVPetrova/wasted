require 'rails_helper'

RSpec.describe Account::IncomesController, type: :controller do
  let(:user) { create :user }

  before { sign_in user }

  describe 'GET index' do
    subject { get :index }

    it { is_expected.to be_success }
  end

  describe 'POST create' do
    let(:label) { create :income_label }
    let(:params) { attributes_for(:income).merge(label_id: label.id) }
    subject { post :create, params: { income: params } }

    it { is_expected.to be_redirect }
  end
end
