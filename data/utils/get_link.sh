 
 #!/bin/bash


year=$1
game_type=$2

curl 'https://www.ficsgames.org/cgi-bin/download.cgi' \
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
  --data-raw 'gametype=%{game_type}&player=&year='${year}'&month=0&movetimes=0&download=Download' \
  --compressed | awk '{print $0}' | grep "he requested games can be downloaded from he" | sed 's/The requested games can be downloaded from here//g' \
  | sed 's/archive size://g'| sed 's/div class=\"messagetext\"//g'| sed 's/\"/ /g' | awk '{print $7}'
