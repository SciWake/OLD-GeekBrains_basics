def binary_search(array, num):
    left = 0
    right = len(array) - 1

    while left <= right:
        mid = (left + right) // 2
        guess = array[mid]
        if guess == num:
            return mid
        if guess > num:
            right = mid - 1
        else:
            left = mid + 1
    return None
