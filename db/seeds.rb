user = User.where(email: 'madfisher42@gmail.com').first_or_create(password: '1234567890', name: 'Yana')

['Зарплата', 'Проценты от банка', 'Аванс'].each do |title|
  user.income_labels.create(title: title)
end

['Завтрак', 'Кофе', 'Обед', 'Ужин', 'Косметика', 'Вкусное'].each do |title|
  user.random_expense_labels.create(title: title)
end

['Кредитка', 'Аренда', 'Мобильный', 'Копим', 'Коммуналка', 'Проезд'].each do |title|
  user.recurrent_expense_labels.create(title: title)
end
