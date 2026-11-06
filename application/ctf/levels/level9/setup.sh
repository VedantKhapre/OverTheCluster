#!/bin/bash
set -e
FLAG="flag{$(openssl rand -hex 8)}"

mkdir -p /home/level9/files
for i in $(seq 1 50); do
    f=/home/level9/files/file_$(printf "%02d" $i).txt
    for j in $(seq 1 30); do
        echo "INFO node=$i tick=$RANDOM" >> "$f"
    done
    if [ $((i % 3)) -ne 0 ]; then
        echo "flag{decoy_$RANDOM}" >> "$f"
    fi
done
echo "SUCCESS: real flag $FLAG" >> /home/level9/files/file_17.txt

find /home/level9/files -type f -exec chown level9:level9 {} \; -exec chmod 644 {} \;
chown level9:level9 /home/level9/files
chmod 755 /home/level9/files

cp /opt/levels/level9/Challenge.txt /home/level9/Challenge.txt
chown level9:level9 /home/level9/Challenge.txt

echo "level10:$FLAG" | chpasswd

mkdir -p /etc/ctf
cp /opt/levels/level9/banner.txt /etc/ctf/level9.txt
chmod 644 /etc/ctf/level9.txt
echo 'cat /etc/ctf/level9.txt' >> /home/level9/.bashrc
