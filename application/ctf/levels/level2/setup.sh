#!/bin/bash
set -e
FLAG="flag{$(openssl rand -hex 8)}"

mkdir -p /home/level2/docs/archive/.cache
echo "Not here." > /home/level2/docs/readme.txt
echo "Try again." > /home/level2/docs/archive/notes.txt
echo "$FLAG"     > /home/level2/docs/archive/.cache/.flag.txt

find /home/level2/docs -type f -exec chown level2:level2 {} \; -exec chmod 644 {} \;
find /home/level2/docs -type d -exec chmod 755 {} \;

cp /opt/levels/level2/Challenge.txt /home/level2/Challenge.txt
chown level2:level2 /home/level2/Challenge.txt

echo "level3:$FLAG" | chpasswd

mkdir -p /etc/ctf
cp /opt/levels/level2/banner.txt /etc/ctf/level2.txt
chmod 644 /etc/ctf/level2.txt
echo 'cat /etc/ctf/level2.txt' >> /home/level2/.bashrc