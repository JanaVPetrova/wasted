class SessionsController < ApplicationController
  def new
  end

  def create
    result = Users::Authenticate.call(
      email: session_params[:email],
      password: session_params[:password]
    )

    if result.success?
      sign_in result.user
      redirect_to account_root_path
    else
      flash[:error] = result.error
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
