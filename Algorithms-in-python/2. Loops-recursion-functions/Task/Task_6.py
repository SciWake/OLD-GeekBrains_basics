# 6. В программе генерируется случайное целое число от 0 до 100. Пользователь должен его отгадать
# не более чем за 10 попыток. После каждой неудачной попытки должно сообщаться,
# больше или меньше введенное пользователем число, чем то, что загадано.
# Если за 10 попыток число не отгадано, вывести ответ.
import random as rd

pc_number = rd.randint(0, 100)

for i in range(10):
    user_number = int(input('Какое число я загадал?: '))
    print('Ваше число больше загаданного') if user_number > pc_number else print('Ваше число меньше загаданного')
    if pc_number == user_number:
        print('Вы угадали :)')
        break

print('Загаданное число было: ', pc_number)