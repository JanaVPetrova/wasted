class Cards::Sync
  include Interactor

  delegate :user, :client, to: :context

  before { context.client ||= Openbank.new }

  def call
    sync_cards!
  end

  private

  def sync_cards!
    client.cards_list.each do |card_data|
      user.cards.where(external_id: card_data[:external_id]).first_or_create!(
        card_data.merge(synced_at: Time.current)
      )
    end
  end
end
