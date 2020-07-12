def binary_search(array, num):
    left = 0
    right = len(array) - 1

    while left <= right:
        mid = (left + right)
        guess = array[mid]
        if guess == num:
            return mid
        if guess > num:
            right = mid - 1
        else:
            left = mid + 1
    return None


a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(binary_search(a, 10))
