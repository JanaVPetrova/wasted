require 'rails_helper'

RSpec.describe Account::RandomExpensesController do
  render_views

  let(:user) { create :user }

  before { sign_in user }

  describe 'GET #index' do
    subject { get :index }

    it 'returns http success' do
      is_expected.to have_http_status(:success)
    end
  end

  # describe 'GET #create' do
  #   it 'returns http success' do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET #update' do
  #   it 'returns http success' do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET #destroy' do
  #   it 'returns http success' do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
