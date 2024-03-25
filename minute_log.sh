#!/bin/bash
#conf crontab
# * * * * * /home/kyfaiyya/log/minute_log.sh
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

MEM_INFO=$(free -m | awk 'NR==2{print $2","$3","$4","$5","$6","$7}')

SWAP_INFO=$(awk '/SwapTotal/{total=$2}/SwapFree/{free=$2}END{print total","(total-free)","free}' /proc/meminfo)

DEFAULT_PATH="/home/kyfaiyya"

PATH_SIZE=$(/usr/bin/du -sh "$DEFAULT_PATH" | /usr/bin/awk '{print $1}')

LOG_DIR="/home/kyfaiyya/log/"

mkdir -p "$LOG_DIR"

echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size $MEM_INFO,$SWAP_INFO,$DEFAULT_PATH,$PATH_SIZE" > "${LOG_DIR}metrics_${TIMESTAMP}.log"
