n = int(input('До какого числа вы хотите получить простые числа: '))

sieve = [i for i in range(n)]
sieve[1] = 0

for i in range(2, n):

    if sieve[i] != 0:
        j = i * 2

        while j < n:
            sieve[j] = 0
            j += i

result = [i for i in sieve if i != 0]

print(result)
