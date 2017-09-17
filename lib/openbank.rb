class Openbank
  include HTTParty

  base_uri 'https://api.open.ru'

  def cards_list
    path = '/MyCards/1.0.0/MyCardsInfo/cardlist'
    response = self.class.get(path, {})

    if response.success?
      response.parsed_response['Cards']['Card'].map do |raw_card|
        {
          external_id: raw_card['CardId'],
          title: raw_card['CardName'],
          kind: raw_card['CardType'],
          payment_system: raw_card['CardPaymentSystem']
        }
      end
    end
  end

  def transactions_history(card_id, since = Time.current)
    path = '/MyCards/1.0.0/MyCardsInfo/history'
    response = self.class.post(
      path,
      body: { 'CardId': card_id.to_i, 'Since': since }.to_json,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    )

    if response.success?
      response.parsed_response['CardTransactionsList'].flat_map do |group|
        group['CardTransaction'].map do |transaction|
          {
            time: Time.parse(transaction['TransactionDate']),
            title: transaction['TransactionPlace'],
            amount_cents: (transaction['TransactionSum'].to_f * 100),
            amount_currency: (transaction['TransactionCur'])
          }
        end
      end
    end
  end

  def nearest_atm_address(latitude, longitude)
    path = '/geocoding/1.0.0/getNearATM'
    response = self.class.post(
      path,
      body: nearest_atm_body(latitude, longitude),
      headers: {
        'Content-Type': 'text/xml',
        'Accept': 'text/xml'
      }
    )

    if response.success?
      response.parsed_response['getNearATMResponse']['return']['poiList']['formattedAddress']
    else
      ''
    end
  end

  def currency
    path = '/getrates/1.0.0/rates/cash'
    response = self.class.get(path)

    if response.success?
      normalize(response.parsed_response['rates'])
    end
  end

  private

  def normalize(data)
    data.map { |card_data| Hash[card_data.map { |k, v| [k.underscore.to_sym, v] }] }
  end

  def nearest_atm_body(latitude, longitude)
    '<?xml version="1.0"?>' +
    "<getNearATM>" +
      "<coordinates>" +
        "<latitude>#{latitude}</latitude>" +
        "<longitude>#{longitude}</longitude>" +
      "</coordinates>" +
    "</getNearATM>"
  end
end
