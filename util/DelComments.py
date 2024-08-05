# -*- coding: utf-8 -*-

import re

def del_comments(SRC_PATH: str, DST_PATH: str) -> None:
    with open(SRC_PATH, 'r', encoding='utf-8') as file:
        content = file.read()

    content = re.sub(r'//.*', '', content) # 删除单行注释
    content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL) # 删除多行注释

    with open(DST_PATH, 'w', encoding='utf-8') as file:
        file.write(content)

def strip_trailing_spaces(SRC_PATH: str, DST_PATH: str) -> None:
    with open(SRC_PATH, 'r') as file:
        lines = file.readlines()

    stripped_lines = [line.rstrip() for line in lines]

    with open(DST_PATH, 'w') as file:
        file.write('\n'.join(stripped_lines))

# Example
if __name__ == '__main__':
    del_comments(f'sim_tb_top.v', f'sim_tb_top.DelComments.v')
