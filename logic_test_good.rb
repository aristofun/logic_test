# encoding: utf-8
#
# Тест на абстрактное логическое мышление
#
# http://syntone.ru/psytesty/test-logicheskogo-myshleniya
#
# Версия c соблюдением стандартов форматирования кода ruby

# Подключим отдельный файл с массивом вопросов и правильных ответов
require_relative 'questions_keys'

name = ARGV[0]

# Выводим приветствие
puts "Привет, #{name.encode('UTF-8')}" if name
puts 'Тест на логику вашего мышления. У вас есть 8 минут на 12 вопросов!'
sleep 1

# Создадим массив, в который будем складывать ответы пользователя
user_answers = []

# Запишем время начала теста в переменную start_time
start_time = Time.now

# Основной игровой цикл — задаем все вопросы подряд
QUESTIONS.each do |question|
  # Выведем вопрос, который лежит в первом элементе вложенного массива
  puts
  puts question[0]
  puts

  # Выведем варианты ответов, которые лежат в остальных элементах массива
  puts 'Варианты ответов (можно указать несколько через запятую)'
  question.each_with_index do |variant, i|
    puts "#{i}: #{variant}" unless i.zero?
  end

  # Получаем ответ от пользователя, добиваемся ввода какой-то строки, очищаем её
  # от лишних пробелов и добавляем в массив user_answers
  user_input = ''
  user_input = STDIN.gets.chomp.delete(' ') if user_input.empty?
  user_answers << user_input
end

# В переменной score будем хранить счет игрока
score = 0

# Пройдемся по всем его ответам и если ответ совпадает с ключе, увеличиваем счет
user_answers.each_with_index do |answer, i|
  score += 1 if answer == KEYS[i]
end

# Вычисляем, сколько времени ушло у человек на прохождение теста и выводим,
# успел он или нет (если больше 8 минут)
minutes_spent = (Time.now - start_time) / 60
puts "Вы потратили на тест: #{minutes_spent} мин."
puts 'Не уложились! Идите учиться!!!' if minutes_spent > 8

# С помощью оператора case запишем результат теста в переменную result
result = case score
         when 0..2 then 'с логикой у вас очень слабо'
         when 3..6 then 'логика не отсутствует, но, наверное, имеет смысл ее ' \
           'потренировать.'
         when 7..10 then 'вполне приемлемый результат, говорящий о нормально ' \
           'развитых логических способностях'
         when 11..12 then 'говорят о хорошо развитых логических ' \
           'способностях. Вас трудно убедить речами, в которых есть ' \
           'логические неувязки. Вы видите многие ситуации «насквозь» ' \
           'и можете «предсказывать» поведение людей из вашего окружения'
         end

puts "Ваш результат: #{score}, #{result}"
