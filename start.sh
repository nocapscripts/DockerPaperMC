#!/bin/bash

# Start SSH server
systemctl enable ssh
systemctl enable vsftpd
systemctl enable ufw

service ufw start
ufw allow OpenSSH 
ufw allow 25565/tcp 
ufw allow 21/tcp 
ufw allow 30000:31000/tcp 
ufw --force enable

service ssh start
service vsftpd start




# Run PaperMC
exec java -Xms8G -Xmx8G -jar /home/admin/papermc/paper.jar nogui
