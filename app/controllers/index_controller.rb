class IndexController < ApplicationController
  def show
    if current_user.present?
      redirect_to account_root_path
    else
      redirect_to new_user_path
    end
  end
end
