#!/bin/bash
set -e
FLAG="flag{$(openssl rand -hex 8)}"

echo -n "$FLAG" | base64 > /home/level5/encoded.txt
chown level5:level5 /home/level5/encoded.txt
chmod 644 /home/level5/encoded.txt

cp /opt/levels/level5/Challenge.txt /home/level5/Challenge.txt
chown level5:level5 /home/level5/Challenge.txt

echo "level6:$FLAG" | chpasswd

mkdir -p /etc/ctf
cp /opt/levels/level5/banner.txt /etc/ctf/level5.txt
chmod 644 /etc/ctf/level5.txt
echo 'cat /etc/ctf/level5.txt' >> /home/level5/.bashrc