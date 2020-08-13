from binarytree import bst


def search(bin_search_tree, number, path=''):
    if bin_search_tree.value == number:
        return f'Число {number} обнаружено по следующему пути: \nКорень{path}'

    if number < bin_search_tree.value and bin_search_tree.left != None:
        return search(bin_search_tree.left, number, path=f'{path}\nШаг влево')

    if number > bin_search_tree.value and bin_search_tree.right != None:
        return search(bin_search_tree.right, number, path=f'{path}\nШаг вправо')
    return f'Число {number} отсутствует в дереве'


bt = bst(height=5, is_perfect=False)
print(bt)

num = int(input('Введите число для поиска: '))
print(search(bt, num))
