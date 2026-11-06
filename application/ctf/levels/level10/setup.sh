#!/bin/bash
set -e
FLAG="flag{$(openssl rand -hex 8)}"

mkdir -p /home/level10/.hidden_dir

HEX=$(echo -n "$FLAG" | xxd -p | tr -d '\n')
echo -n "$HEX" | base64 > /home/level10/.hidden_dir/secret.enc

find /home/level10/.hidden_dir -type f -exec chown level10:level10 {} \; -exec chmod 644 {} \;
find /home/level10/.hidden_dir -type d -exec chmod 755 {} \;

cp /opt/levels/level10/Challenge.txt /home/level10/Challenge.txt
chown level10:level10 /home/level10/Challenge.txt

mkdir -p /etc/ctf
cp /opt/levels/level10/banner.txt /etc/ctf/level10.txt
chmod 644 /etc/ctf/level10.txt
echo 'cat /etc/ctf/level10.txt' >> /home/level10/.bashrc