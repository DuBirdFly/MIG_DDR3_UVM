# -*- coding: utf-8 -*-

def strip_trailing_spaces(SRC_PATH: str, DST_PATH: str) -> None:
    with open(SRC_PATH, 'r') as file:
        lines = file.readlines()

    stripped_lines = [line.rstrip() for line in lines]

    with open(DST_PATH, 'w') as file:
        file.write('\n'.join(stripped_lines))


if __name__ == '__main__':
    strip_trailing_spaces(f'sim_tb_top.DelComments.v', f'sim_tb_top.DelComments.StripTrailingSpace.v')
