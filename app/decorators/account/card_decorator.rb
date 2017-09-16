class Account::CardDecorator < Draper::Decorator
  delegate_all

  def humanize
    "[#{object.payment_system}] #{object.title} (#{object.synced_at})"
  end

end
