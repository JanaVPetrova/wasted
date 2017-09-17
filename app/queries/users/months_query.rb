class Users::MonthsQuery
  attr_reader :user

  def self.call(user:)
    new(user: user).call
  end

  def initialize(user:)
    @user = user
  end

  def call
    user.days.where(date: month)
  end

  private

  def month
    (Date.today.beginning_of_month..Date.today.end_of_month)
  end
end
