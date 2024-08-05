# -*- coding: utf-8 -*-

import os, re
from tracemalloc import start
from util.GetPorts import get_ports

if __name__ == '__main__':
    outputs, inouts, inputs = get_ports( f'inst_part.sv')

    SRC_PATH : str = 'top.sv'
    TAR_PATH : str = f'{SRC_PATH}.port'

    with open(SRC_PATH, 'r') as fi, open(TAR_PATH, 'w') as fo:
        for line in fi.readlines():

            line_strip : str = line.strip()
            idx : int = line.find('.')

            if idx == -1:
                fo.write(line)
                continue

            if ma := re.search(r'\.(\w+)', line):
                possible_port : str = ma.group(1)
            else: raise Exception(f'Find the "." but not match the pattern.')

            # 如果该例化端口不在 outputs, inouts, inputs 端口中，则注释掉
            if possible_port not in outputs and possible_port not in inouts and possible_port not in inputs:
                fo.write(line[:idx] + '// ' + line[idx:])
            else:
                fo.write(line)
