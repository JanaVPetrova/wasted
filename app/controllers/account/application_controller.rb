class Account::ApplicationController < ApplicationController
  layout 'account'

  before_action :authenticate_user!
end
