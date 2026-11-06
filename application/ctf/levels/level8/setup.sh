#!/bin/bash
set -e
FLAG="flag{$(openssl rand -hex 8)}"

DUMP=/home/level8/dump.bin
head -c 4096 /dev/urandom > "$DUMP"
echo ""                >> "$DUMP"
echo "=== flag ===" >> "$DUMP"
echo "$FLAG"           >> "$DUMP"
echo "=== end ==="  >> "$DUMP"
head -c 1024 /dev/urandom >> "$DUMP"

chown level8:level8 "$DUMP"
chmod 644 "$DUMP"

cp /opt/levels/level8/Challenge.txt /home/level8/Challenge.txt
chown level8:level8 /home/level8/Challenge.txt

echo "level9:$FLAG" | chpasswd

mkdir -p /etc/ctf
cp /opt/levels/level8/banner.txt /etc/ctf/level8.txt
chmod 644 /etc/ctf/level8.txt
echo 'cat /etc/ctf/level8.txt' >> /home/level8/.bashrc
