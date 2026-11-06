#!/bin/bash
set -e
FLAG="flag{$(openssl rand -hex 8)}"

echo -n "$FLAG" | tr 'A-Za-z' 'N-ZA-Mn-za-m' > /home/level7/cipher.txt
chown level7:level7 /home/level7/cipher.txt
chmod 644 /home/level7/cipher.txt

cp /opt/levels/level7/Challenge.txt /home/level7/Challenge.txt
chown level7:level7 /home/level7/Challenge.txt

echo "level8:$FLAG" | chpasswd

mkdir -p /etc/ctf
cp /opt/levels/level7/banner.txt /etc/ctf/level7.txt
chmod 644 /etc/ctf/level7.txt
echo 'cat /etc/ctf/level7.txt' >> /home/level7/.bashrc
