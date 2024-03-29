#!/bin/bash

function get_link(){
    year=$1
    echo "Getting link for year $year"
URL=$(curl 'https://www.ficsgames.org/cgi-bin/download.cgi' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: https://www.ficsgames.org' \
  -H 'Referer: https://www.ficsgames.org/download.html' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36' \
  -H 'sec-ch-ua: "Chromium";v="116", "Not)A;Brand";v="24", "Google Chrome";v="116"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  --data-raw 'gametype=3&player=&year='${year}'&month=0&movetimes=0&download=Download' \
  --compressed | awk '{print $0}' | grep "he requested games can be downloaded from he" | sed 's/The requested games can be downloaded from here//g' \
  | sed 's/archive size://g'| sed 's/div class=\"messagetext\"//g'| sed 's/\"/ /g' | awk '{print $7}')

echo "Will now download content"
wget https://www.ficsgames.org/$URL
}

function get_link_blitz(){
    year=$1
    echo "Getting link for year $year"
URL=$(curl 'https://www.ficsgames.org/cgi-bin/download.cgi' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: https://www.ficsgames.org' \
  -H 'Referer: https://www.ficsgames.org/download.html' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36' \
  -H 'sec-ch-ua: "Chromium";v="116", "Not)A;Brand";v="24", "Google Chrome";v="116"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  --data-raw 'gametype=5&player=&year='${year}'&month=0&movetimes=0&download=Download' \
  --compressed | awk '{print $0}' | grep "he requested games can be downloaded from he" | sed 's/The requested games can be downloaded from here//g' \
  | sed 's/archive size://g'| sed 's/div class=\"messagetext\"//g'| sed 's/\"/ /g' | awk '{print $7}')

echo "Will now download content"
wget https://www.ficsgames.org/$URL

 }

function get_link_lightning(){

    year=$1
    echo "Getting link for year $year"
URL=$(curl 'https://www.ficsgames.org/cgi-bin/download.cgi' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: https://www.ficsgames.org' \
  -H 'Referer: https://www.ficsgames.org/download.html' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36' \
  -H 'sec-ch-ua: "Chromium";v="116", "Not)A;Brand";v="24", "Google Chrome";v="116"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Linux"' \
  --data-raw 'gametype=7&player=&year='${year}'&month=0&movetimes=0&download=Download' \
  --compressed | awk '{print $0}' | grep "he requested games can be downloaded from he" | sed 's/The requested games can be downloaded from here//g' \
  | sed 's/archive size://g'| sed 's/div class=\"messagetext\"//g'| sed 's/\"/ /g' | awk '{print $7}')

echo "Will now download content"
wget https://www.ficsgames.org/$URL
}

function  extract_game(){
    year=$1
    filename=$(ls | grep ".pgn.bz2" | grep $year)
    mv ${filename} ${year}.pgn.bz2
    bzip2 -d ${year}.pgn.bz2;
}


function  split_game(){
    year=$1
    CURR_DIR=$(pwd)
    mkdir -p data
    mkdir -p data/${year}/
    mv ${year}.pgn data/${year}/full.pgn
    cd data/${year}
    pgn-extract -#10000 full.pgn 
    rm full.pgn
    cd ${CURR_DIR}
}

function  convert_to_json_bad(){
    year=$1
    CURR_DIR=$(pwd)
    # cd data/${year}
    #  ls | grep ".pgn" | sed 's/.pgn//g' | sort | awk '{print "pgn-extract  --json "$1".pgn > "$1".json"}' |bash -
    ls | grep ".pgn" | xargs rm
    cd ${CURR_DIR}
}


function  fix_bad_json(){
    year=$1
    python fix_json_files.py --dir $(pwd)/data/${year}
    ls $(pwd)/data/${year} | grep ".json" |  grep -v "_fixed.json" | awk -v path="data/${year}/" '{print "rm "path""$1}' | bash -
    ls $(pwd)/data/${year} | grep ".json" |  sed 's/_fixed.json//g' |  awk -v path="data/${year}/" '{print "mv "path""$1"_fixed.json "path""$1".json"}' | bash -
}



function  json_to_csv(){
    year=$1
    python json_to_csv.py --dir $(pwd)/data/${year}
        find $(pwd)/data/${year} -name "*.json" | xargs rm
}
function  merge_csv(){
    year=$1
    python merge_csv.py --dir $(pwd)/data/${year}  --dst $(pwd)/data/${year}/${year}.csv
}


function setup_year_lightning(){
year=$1
echo "====== setup ${year} ======"   
echo "====== get_link ======"   
get_link_lightning  ${year}
echo "====== extract_game ======"   
extract_game ${year}
echo "====== split_game ======"   
split_game ${year}
echo "====== convert_to_json_bad ======"   
convert_to_json_bad ${year}
echo "====== fix_bad_json ======"   
fix_bad_json ${year}
echo "====== json_to_csv ======"   
json_to_csv ${year}
echo "====== merge_csv ======"   
merge_csv ${year}
}

function setup_year(){
year=$1
# echo "====== setup ${year} ======"   
# echo "====== get_link ======"   
# get_link  ${year}
# echo "====== extract_game ======"   
# extract_game ${year}
# echo "====== split_game ======"   
# split_game ${year}
# echo "====== convert_to_json_bad ======"   
# convert_to_json_bad ${year}
# echo "====== fix_bad_json ======"   
# fix_bad_json ${year}
# echo "====== json_to_csv ======"   
json_to_csv ${year}
# echo "====== merge_csv ======"   
merge_csv ${year}
}



function setup_year_blitz(){
year=$1
echo "====== setup ${year} ======"   
echo "====== get_link ======"   
get_link_blitz  ${year}
echo "====== extract_game ======"   
extract_game ${year}
echo "====== split_game ======"   
split_game ${year}
# echo "====== convert_to_json_bad ======"   
# convert_to_json_bad ${year}
# echo "====== fix_bad_json ======"   
# fix_bad_json ${year}
# echo "====== json_to_csv ======"   
# json_to_csv ${year}
# echo "====== merge_csv ======"   
# merge_csv ${year}
}






setup_year 1998
setup_year 1999
setup_year 2000
setup_year 2001
setup_year 2002
setup_year 2003
setup_year 2004
setup_year 2005
setup_year 2006
setup_year 2007
# setup_year_blitz 2008
# setup_year_blitz 2009
# setup_year_blitz 2010
# setup_year_blitz 2011
# setup_year_blitz 2012
# setup_year_blitz 2013
# setup_year_blitz 2014
# setup_year_blitz 2015
# setup_year_blitz 2016
# setup_year_blitz 2017
# setup_year_blitz 2018
# setup_year_blitz 2019
# setup_year_blitz 2020
# setup_year_blitz 2021
# setup_year_blitz 2022
# setup_year_blitz 2023
