
import argparse

import os
from tqdm import tqdm
import json
import re


def get_json_file_Content(src_file):
    with open(src_file,"r+") as f:
        return json.load(f)

def convert_to_csv(src, dest):
    file_content=get_json_file_Content(src)
    with open(dest,"w+") as f:
        headers=sorted(list(file_content[0].keys()))
        # print(",".join(headers)+"\n")
        f.write(",".join(headers)+"\n")
        for row in file_content:
            values=[]
            for h in headers:
                if h=="Moves":
                    moves=[m['move'] for m in row[h]]
                    if len(moves)==0:
                        values.append("?")
                    else:
                        values.append("|".join(moves))
                        
                else:
                    values.append(row.get(h,"?"))
            # print(",".join(values)+"\n")
            f.write(",".join(values)+"\n")
        #     headers=sorted(list(row.keys()))
        #     print(headers)


parser = argparse.ArgumentParser(description='add, modify and delete upstream nodes')
parser.add_argument('--dir', required=True, type=str,  help='')
args = parser.parse_args()
src_dir = args.dir
print(src_dir)


if os.path.isdir(src_dir):
    all_json_files=[f for f in os.listdir(src_dir) if ".json" in f ]
    for src_file in tqdm(all_json_files):
        output=src_file.replace(".json", ".csv")
        convert_to_csv(src_dir+"/"+src_file,src_dir+"/"+output)