require 'rails_helper'

RSpec.describe Account::IncomesController do
  render_views

  let(:user) { create :user }
  let(:income) { create :income, user: user }

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

  describe 'GET edit' do
    subject { get :edit, params: { id: income.id } }

    it { is_expected.to be_success }
  end

  describe 'PATCH update' do
    let(:amount_cents) { generate :integer }
    subject { patch :update, params: { id: income.id, income: { amount_cents: amount_cents } } }

    it 'updates income' do
      is_expected.to be_redirect
      expect(income.reload.amount_cents).to eq amount_cents
    end
  end
end
