import json
import math
import os
import random
import re
import shutil
import sys
import time
from collections import defaultdict
from pathlib import Path
from datetime import datetime

from loguru import logger

sys.path.append(os.path.abspath('.'))

SEED = 0
random.seed(SEED)


def parse_txt_file(file):
    with open(file, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    values = []
    for line in lines:
        items = line.strip().split('\t')
        new_items = []
        for item in items:
            if item == '\\N':
                item = 'NULL'
            else:
                item = f"'{item}'"
            print(item)
            new_items.append(item)
        values.append(f'({", ".join(new_items)})')
    return values    
    
def convert_pet_txt_to_insert_sql():
    file = 'menagerie-db\pet.txt'
    values = parse_txt_file(file)
    sql = f"INSERT INTO pet VALUES {', '.join(values)};"
    sql_file = 'menagerie-db\pet_insert.sql'
    with open(sql_file, 'w', encoding='utf-8') as f:
        f.write(sql)


def convert_event_txt_to_insert_sql():
    file = 'menagerie-db\event.txt'
    values = parse_txt_file(file)
    sql = f"INSERT INTO event VALUES {', '.join(values)};"
    sql_file = 'menagerie-db\event_insert.sql'
    with open(sql_file, 'w', encoding='utf-8') as f:
        f.write(sql)


if __name__ == '__main__':
    convert_pet_txt_to_insert_sql()
    convert_event_txt_to_insert_sql()
    logger.info('end')
