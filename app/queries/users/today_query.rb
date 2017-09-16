class Users::TodayQuery
  attr_reader :user

  def self.call(user:)
    new(user: user).call
  end

  def initialize(user:)
    @user = user
  end

  def call
    user.days.find_by(date: Date.today)
  end
end
