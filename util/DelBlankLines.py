# -*- coding: utf-8 -*-

import os

def del_blank_lines(FILE_PATH: str) -> None:
    with open(FILE_PATH, 'r') as file:
        lines = [line for line in file.readlines() if line.strip()]

    with open(FILE_PATH, 'w') as file:
        file.writelines(lines)

if __name__ == '__main__':

    paths : list[str] = []

    # for root, dirs, files in os.walk('../imports'):
    #     for file in files:
    #         paths.append(f'{root}/{file}')

    paths.append('../dut/mig_mig_sim.v')
    paths.append('../dut/mig_mig.v')
    paths.append('../dut/mig.v')

    for path in paths:
        print(path)
        del_blank_lines(path)
