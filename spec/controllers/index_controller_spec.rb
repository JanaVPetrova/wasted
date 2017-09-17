require 'rails_helper'

RSpec.describe IndexController do
  render_views

  describe 'GET show' do
    subject { get :show }

    it { is_expected.to be_redirect }
  end
end
