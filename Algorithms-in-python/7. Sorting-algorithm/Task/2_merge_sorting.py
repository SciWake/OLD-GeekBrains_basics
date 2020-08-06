import random

# Генерация массива
size = 100
array = [i for i in range(0, size)]
random.shuffle(array)
print(array)


def merge(left_list, right_list):
    sorted_list = []
    left_index = right_index = 0
    left_length, right_length = len(left_list), len(right_list)

    for _ in range(left_length + right_length):
        if left_index < left_length and right_index < right_length:
            if left_list[left_index] <= right_list[right_index]:
                sorted_list.append(left_list[left_index])
                left_index += 1
            else:
                sorted_list.append(right_list[right_index])
                right_index += 1
        elif left_index == left_length:
            sorted_list.append(right_list[right_index])
            right_index += 1
        elif right_index == right_length:
            sorted_list.append(left_list[left_index])
            left_index += 1
    return sorted_list


def merge_sort(nums):
    if len(nums) <= 1:
        return nums

    mid = len(nums) // 2

    left_list = merge_sort(nums[:mid])
    right_list = merge_sort(nums[mid:])

    return merge(left_list, right_list)


print(merge_sort(array))
