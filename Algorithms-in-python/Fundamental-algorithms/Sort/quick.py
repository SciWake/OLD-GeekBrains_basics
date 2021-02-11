import random

# Генерация массива
size = 7
array = [i for i in range(size)]
random.shuffle(array)
print(array)


# РЕАЛИЗАЦИЯ 1

# Данная версия требует дополнительной памяти
def quick_sort(array):
    if len(array) <= 1:
        return array
    pivot = random.choice(array)
    s_ar = []
    m_ar = []
    l_ar = []

    for item in array:

        if item < pivot:
            s_ar.append(item)
        elif item > pivot:
            l_ar.append(item)
        elif item == pivot:
            m_ar.append(item)
        else:
            raise Exception(f'Необычный элемент {item}')

    return quick_sort(s_ar) + m_ar + quick_sort(l_ar)
