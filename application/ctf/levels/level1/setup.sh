#!/bin/bash
set -e
FLAG="flag{$(openssl rand -hex 8)}"

echo "$FLAG" > /home/level1/flag.txt
chown level1:level1 /home/level1/flag.txt
chmod 644 /home/level1/flag.txt

cp /opt/levels/level1/Challenge.txt /home/level1/Challenge.txt
chown level1:level1 /home/level1/Challenge.txt

echo "level2:$FLAG" | chpasswd

mkdir -p /etc/ctf
cp /opt/levels/level1/banner.txt /etc/ctf/level1.txt
chmod 644 /etc/ctf/level1.txt
echo 'cat /etc/ctf/level1.txt' >> /home/level1/.bashrc