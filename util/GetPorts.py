# -*- coding: utf-8 -*-

import os, re

def get_ports(SRC_PATH : str) -> tuple[list[str], list[str], list[str]]:
    outputs : list[str] = []
    inouts  : list[str] = []
    inputs  : list[str] = []

    if not os.path.exists(SRC_PATH):
        raise FileNotFoundError(f'File not found: {SRC_PATH}')

    if not SRC_PATH.endswith('.v') and not SRC_PATH.endswith('.sv'):
        raise ValueError(f'File type not supported (only .v and .sv): {SRC_PATH}')

    for line in open(SRC_PATH, 'r').readlines():
        line = line.strip()

        if ma := re.match(r'^(.*?);', line):
            line = ma.group(1)
        else: continue

        words : list[str] = line.split()

        match words[0]:
            case 'output': outputs.append(words[-1])
            case 'inout':  inouts.append(words[-1])
            case 'input':  inputs.append(words[-1])
            case _: pass

    outputs = sorted(outputs)
    inouts  = sorted(inouts)
    inputs  = sorted(inputs)

    return outputs, inouts, inputs

def write_ports_signal(TAR_PATH : str, outputs : list[str], inouts : list[str], inputs : list[str]) -> None:
    with open(TAR_PATH, 'w') as f:
        f.write(' ' * 4 + f'//* Outputs *******************************\n')
        for i, port in enumerate(outputs):
            f.write(' ' * 4 + f'{port},')
            f.write(f'\n')

        f.write(' ' * 4 + f'//* Inouts *******************************\n')
        for i, port in enumerate(inouts):
            f.write(' ' * 4 + f'{port},')
            f.write(f'\n')

        f.write(' ' * 4 + f'//* Inputs *******************************\n')
        for i, port in enumerate(inputs):
            f.write(' ' * 4 + f'{port}')
            
            if i < len(inputs) - 1: f.write(f',\n')
            else:                   f.write(f'\n')

def write_ports_inst(TAR_PATH : str, outputs : list[str], inouts : list[str], inputs : list[str]) -> None:
    with open(TAR_PATH, 'w') as f:
        f.write(' ' * 4 + f'//* Outputs *******************************\n')
        max_len : int = max([len(port) for port in outputs])
        for i, port in enumerate(outputs):
            f.write(' ' * 4 + f'.{port:<{max_len}} ( {port:<{max_len}} )')
            f.write(f',\n')

        f.write(' ' * 4 + f'//* Inouts *******************************\n')
        max_len : int = max([len(port) for port in inouts])
        for i, port in enumerate(inouts):
            f.write(' ' * 4 + f'.{port:<{max_len}} ( {port:<{max_len}} )')
            f.write(f',\n')

        f.write(' ' * 4 + f'//* Inputs *******************************\n')
        max_len : int = max([len(port) for port in inputs])
        for i, port in enumerate(inputs):
            f.write(' ' * 4 + f'.{port:<{max_len}} ( {port:<{max_len}} )')

            if i < len(inputs) - 1: f.write(f',\n')
            else:                   f.write(f'\n')

if __name__ == '__main__':
    # SRC_PATH : str = f'inst_full.sv'
    SRC_PATH : str = f'inst_part.sv'
    TAR_PATH : str = f'{SRC_PATH}.port'

    outputs, inouts, inputs = get_ports(SRC_PATH)

    match SRC_PATH:
        case 'inst_full.sv': write_ports_inst(TAR_PATH, outputs, inouts, inputs)
        case 'inst_part.sv': write_ports_signal(TAR_PATH, outputs, inouts, inputs)
        case _: raise ValueError(f'File name not supported: {SRC_PATH}')


