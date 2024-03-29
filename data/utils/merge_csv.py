
import argparse

import os
from tqdm import tqdm
import pandas as pd



parser = argparse.ArgumentParser(description='add, modify and delete upstream nodes')
parser.add_argument('--dir', required=True, type=str,  help='')
parser.add_argument('--dst', required=True, type=str,  help='')
args = parser.parse_args()
src_dir = args.dir
print(src_dir)


if os.path.isdir(src_dir):
    all_csv_files=[f for f in os.listdir(src_dir) if ".csv" in f ]
    frames=[]
    for src_file in tqdm(all_csv_files):
        frames.append(pd.read_csv(src_dir+"/"+src_file))
    print("merging files")
    result = pd.concat(frames)
    result.to_csv(args.dst)
    print("deleting original files")
    for src_file in tqdm(all_csv_files):
        os.remove(src_dir+"/"+src_file)
    