user = User.where(email: 'madfisher42@gmail.com').first_or_create(password: '1234567890', name: 'Yana')

puts 'user ok'

income_labels = ['Зарплата', 'Проценты от банка', 'Аванс'].map do |title|
  category = Category.create(title: title)
  user.income_labels.create(title: title, category: category)
end

salary = Category.where(title: 'Зарплата').first_or_create!
user.income_labels.create(title: 'Перечисление з/п по реестру', category: salary)

puts 'income_labels ok'

income_labels.each do |label|
  Incomes::Create.call(
    user: user,
    params: { amount_cents: (rand(10) * 10000 * 100), label_id: label.id }
  )
end

puts 'incomes ok'

recurrent_expense_labels = ['Кредитка', 'Аренда', 'Мобильный', 'Копим', 'Коммуналка', 'Проезд'].map do |title|
  category = Category.create(title: title)
  user.recurrent_expense_labels.create(title: title, category: category)
end
cash = Category.where(title: 'Наличные').first_or_create!
transport = Category.where(title: 'Проезд').first_or_create!
food = Category.where(title: 'Еда').first_or_create!
utils = Category.where(title: 'Коммуналка').first_or_create!

user.recurrent_expense_labels.create(title: 'банкомат ФК Открытие', category: cash)
user.recurrent_expense_labels.create(title: 'Перевод с карты на карту', category: cash)
user.recurrent_expense_labels.create(title: 'АЗС Лукойл 101', category: transport)
user.recurrent_expense_labels.create(title: 'Копеечка', category: food)
user.recurrent_expense_labels.create(title: 'Оплата счета провайдера', category: utils)
user.recurrent_expense_labels.create(title: 'Шиномонтаж У Валеры', category: utils)

puts 'recurrent_expense_labels ok'

recurrent_expense_labels.each do |label|
  Expenses::Recurrent::Create.call(
    user: user,
    params: {
      label_id: label.id,
      amount_cents: rand(10) * 1000 * 100,
      spend_at: Time.current
    }
  )
end

puts 'recurrent_expenses ok'

random_expense_labels = ['Завтрак', 'Кофе', 'Обед', 'Ужин', 'Косметика', 'Вкусное'].map do |title|
  category = Category.create(title: title)
  user.random_expense_labels.create(title: title, category: category)
end

puts 'random_expense_labels ok'

(Date.today.beginning_of_month..Date.today).each do |day|
  random_expense_labels.sample(3).each do |label|
    Expenses::Random::Create.call(
      user: user,
      params: {
        label_id: label.id,
        amount_cents: rand(20) * 100 * 100,
        spend_at: (day + 12.hours)
      }
    )
  end
end
