# -*- coding: utf-8 -*-

FILE_1 : str = f'../prj/modelsim.v6.test/log/compile.log'
FILE_2 : str = f'../prj/modelsim.v7/log/compile.log'

list1 : list[str] = open(FILE_1, 'r').readlines()

cnt : int = 0
diff_cnt : int = 0

for line in open(FILE_2, 'r').readlines():
    cnt += 1

    if not line in list1:
        # print(f'[DIFF] [{cnt}] {line}', end='')
        print(f'[DIFF] [{cnt:>6}] {line}', end='')
        diff_cnt += 1
    
    if diff_cnt > 30:
        print(f'[ERROR] Too many differences. Stop comparing.')
        break
