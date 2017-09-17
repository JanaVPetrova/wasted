require 'rails_helper'

RSpec.describe Account::RandomExpensesController do
  render_views

  let(:user) { create :user, :with_incomes }
  let(:random_expense) { create :random_expense, user: user }

  before { sign_in user }

  describe 'GET #index' do
    subject { get :index }

    it 'returns http success' do
      is_expected.to have_http_status(:success)
    end
  end

  describe 'POST create' do
    let(:label) { create :random_expense_label }
    let(:params) { attributes_for(:random_expense).merge(label_id: label.id) }
    subject { post :create, params: { random_expense: params } }

    it { is_expected.to be_redirect }
  end

  describe 'GET edit' do
    subject { get :edit, params: { id: random_expense.id } }

    it { is_expected.to be_success }
  end

  describe 'PATCH update' do
    let(:amount_cents) { generate :integer }
    let(:params) { { id: random_expense.id, random_expense: { amount_cents: amount_cents } } }
    subject { patch :update, params: params }

    it 'updates random_expense' do
      is_expected.to be_redirect
      expect(random_expense.reload.amount_cents).to eq amount_cents
    end
  end
end
