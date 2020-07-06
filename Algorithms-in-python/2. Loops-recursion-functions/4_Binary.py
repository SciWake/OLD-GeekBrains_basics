def binary(num):
    s = ''
    while num > 0:
        s = f'{num % 2}{s}'
        num //= 2
    return s


while True:
    n = int(input('Введите целое чилсо: '))
    if n != 0:
        print(binary(n))
    else:
        break
