#!/bin/bash
set -e
FLAG="flag{$(openssl rand -hex 8)}"

echo "$FLAG" > /home/level6/locked.txt
chown level6:level6 /home/level6/locked.txt
chmod 000 /home/level6/locked.txt

cp /opt/levels/level6/Challenge.txt /home/level6/Challenge.txt
chown level6:level6 /home/level6/Challenge.txt

echo "level7:$FLAG" | chpasswd

mkdir -p /etc/ctf
cp /opt/levels/level6/banner.txt /etc/ctf/level6.txt
chmod 644 /etc/ctf/level6.txt
echo 'cat /etc/ctf/level6.txt' >> /home/level6/.bashrc
