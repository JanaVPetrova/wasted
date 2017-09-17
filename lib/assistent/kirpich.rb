class Assistent::Kirpich
  LIMIT_EXCEEDED = [
    'Едрить ты бестолочь',
    'Завязывай, алё!',
    'Да хорош, ёпта!',
    'Должен будешь!',
    'Доплясался, херувимчик жёванный!',
    'Ты не обостряй!',
    'Забыл, как бычки в глазах шипят?!',
    'Че за терку ты устроил?',
    'Cядем на корты и перейдем на ты',
    'Ты чё Вася, не догоняешь? Харе, говорю',
    'А может на кортах поговорим?',
    'Ты вообще кто по жизни?',
    'Собираешься по беспределу наехать?',
    'Опаньки. Да ты попутал',
    'Вот тебе стул и тряпочка: сиди и молчи',
    'Сделай фокус - растворись в воздухе',
    'Будь осторожен, ибо гнев мой праведный прольётся по лицу твоему бейсбольной битой',
    'Говоришь так, как будто у тебя в карамане запасная челюсть лежит',
    'Тише будь',
    'Ты кто по масти конь дурной?',
    'Отскочим побормочим?',
    'Недолго музыка играла, не долго фраер танцевал',
    'Уж лучше Лолиту, чем 15-летнего капитана'
  ]

  attr_reader :openbank_client, :name

  def initialize(openbank_client = Openbank.new)
    @openbank_client = openbank_client
    @name = 'Павел Кирпич'
  end

  def wants_to_say
    buy_dollar
    buy_euro

    LIMIT_EXCEEDED.sample if rand(10) < 1
  end

  private

  def buy_dollar
    return if rand(10) < 3
    return if currency_data.blank?

    dollar = currency_data.detect { |data| data[:cur_char_code] == 'USD' }

    "Там баксы по #{dollar[:rate_value]}. Брать будешь?"
  end

  def buy_euro
    return if rand(10) < 3
    return if currency_data.blank?

    euro = currency_data.detect { |data| data[:cur_char_code] == 'EUR' }

    "Там евро по #{euro[:rate_value]}. Брать будешь?"
  end

  def currency_data
    @currency_data ||= openbank_client.currency
  end
end
