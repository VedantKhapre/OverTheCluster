#!/bin/bash
set -e
FLAG="flag{$(openssl rand -hex 8)}"

mkdir -p /home/level3/data
for i in $(seq 1 100); do
    f=/home/level3/data/log_$(printf "%03d" $i).log
    for j in $(seq 1 50); do
        echo "2024-01-01 INFO req=$RANDOM status=200" >> "$f"
    done
done
echo "2024-01-01 SECRET $FLAG" >> /home/level3/data/log_042.log

find /home/level3/data -type f -exec chown level3:level3 {} \; -exec chmod 644 {} \;
chown level3:level3 /home/level3/data
chmod 755 /home/level3/data

cp /opt/levels/level3/Challenge.txt /home/level3/Challenge.txt
chown level3:level3 /home/level3/Challenge.txt

echo "level4:$FLAG" | chpasswd

mkdir -p /etc/ctf
cp /opt/levels/level3/banner.txt /etc/ctf/level3.txt
chmod 644 /etc/ctf/level3.txt
echo 'cat /etc/ctf/level3.txt' >> /home/level3/.bashrc