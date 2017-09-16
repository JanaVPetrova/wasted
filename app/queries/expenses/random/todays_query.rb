class Expenses::Random::TodaysQuery
  attr_reader :user

  def self.call(user:)
    new(user: user).call
  end

  def initialize(user:)
    @user = user
  end

  def call
    user.random_expenses.where(spend_at: (Date.today.beginning_of_day..Date.today.end_of_day))
  end
end
