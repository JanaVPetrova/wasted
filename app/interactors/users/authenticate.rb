class Users::Authenticate
  include Interactor

  delegate :email, :password, to: :context

  def call
    context.fail!(error: I18n.t('users.authenticate.no_user')) if user.blank?
    context.fail!(error: I18n.t('users.authenticate.wrong_password')) if wrong_password?

    context.user = user
  end

  private

  def user
    @user ||= User.find_by(email: email)
  end

  def wrong_password?
    !user.authenticate(password)
  end
end
