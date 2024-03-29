
import argparse

import os
from tqdm import tqdm
import json
import re

def get_file_Content(src_file):
    with open(src_file,"r+") as f:
        return f.readlines()


def fix_bad_json(src_file, dst_file):
    lines=[l.replace("\n","") for l in get_file_Content(src_file)]
    fixed_lines=[]
    for l in lines:
        # move line
        if "." in l and "move" in l:
            fixed_lines.append(re.sub(" \d{1,}.","", l))
        else:
            fixed_lines.append(l)
    with open(dst_file,"w+") as f:
        f.write("\n".join(fixed_lines))

parser = argparse.ArgumentParser(description='add, modify and delete upstream nodes')
parser.add_argument('--dir', required=True, type=str,  help='')
args = parser.parse_args()
src_dir = args.dir
if os.path.isdir(src_dir):
    all_json_files=[f for f in os.listdir(src_dir) if ".json" in f and "fixed" not in f]
    
    for src_file in tqdm(all_json_files):
        dst_file=src_file.replace(".json", "_fixed.json")
        fix_bad_json(os.path.join(src_dir,src_file), os.path.join(src_dir,dst_file))
        



