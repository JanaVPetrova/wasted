module ApplicationHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def signed_in?
    !session[:user_id].nil?
  end

  def current_user
    return unless signed_in?

    User.find(session[:user_id])
  end

  def authenticate_user!
    redirect_to(root_path) unless signed_in?
  end
end
