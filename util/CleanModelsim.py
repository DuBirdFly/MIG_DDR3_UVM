# -*- coding: utf-8 -*-

import os, shutil

dirs : list[str] = []

for dir in os.listdir(f'../prj'):
    dirs.append(f'../prj/{dir}')

for dir in dirs:
    path_0 : str = f'{dir}/modelsim_lib/msim'
    path_1 : str = f'{dir}/modelsim_lib/work'

    if os.path.exists(path_0):
        print(f'Removing {path_0}')
        shutil.rmtree(path_0)
    
    if os.path.exists(path_1):
        print(f'Removing {path_1}')
        shutil.rmtree(path_1)
