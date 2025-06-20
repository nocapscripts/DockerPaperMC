#!/bin/bash

# Start SSH server
service ssh start

# Run PaperMC
exec java -Xms8G -Xmx8G -jar /home/admin/papermc/paper.jar nogui
