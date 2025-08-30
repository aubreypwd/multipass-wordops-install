#!/bin/bash

sudo apt install -y samba # 2. Install Samba so you can mount and expose /var/www for live editng.

# 4. Add Samba share config
sudo tee -a /etc/samba/smb.conf > /dev/null <<EOF

[www]
   path = /var/www
   available = yes
   valid users = ubuntu
   read only = no
   browsable = yes
   guest ok = yes
EOF

sudo systemctl restart smbd

sudo wget -qO wo wops.cc && sudo bash wo --force # 1. Install WordOps (force reinstall)

# Setup WordOps
sudo wo secure --auth '' '' # Do not require username/password for dashboard.
sudo wo secure --port 666 # Set port to easy to remember 666.
