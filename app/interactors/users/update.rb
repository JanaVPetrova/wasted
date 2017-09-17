class Users::Update
  include Interactor

  delegate :user, :params, to: :context

  def call
    user.update(params)

    context.fail! if user.errors.any?
  end
end
