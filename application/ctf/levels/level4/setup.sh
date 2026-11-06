#!/bin/bash
set -e
FLAG="flag{$(openssl rand -hex 8)}"

{
    echo "This is actually plain text!"
    echo ""
    echo "Secret: $FLAG"
} > /home/level4/mystery.bin

chown level4:level4 /home/level4/mystery.bin
chmod 644 /home/level4/mystery.bin

cp /opt/levels/level4/Challenge.txt /home/level4/Challenge.txt
chown level4:level4 /home/level4/Challenge.txt

echo "level5:$FLAG" | chpasswd

mkdir -p /etc/ctf
cp /opt/levels/level4/banner.txt /etc/ctf/level4.txt
chmod 644 /etc/ctf/level4.txt
echo 'cat /etc/ctf/level4.txt' >> /home/level4/.bashrc