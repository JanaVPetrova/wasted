class Account::ProfilesController < Account::ApplicationController
  def show
  end

  def update
    result = Users::Update.call(user: current_user, params: user_params)

    redirect_to account_profile_path
  end

  private

  def user_params
    params.require(:user).permit(:assistent)
  end
end
