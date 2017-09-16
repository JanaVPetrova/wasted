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
    if signed_in?
      User.find(session[:user_id])
    else
      nil
    end
  end

  def authenticate_user!
    unless signed_in?
      redirect_to root_path
    end
  end
end
