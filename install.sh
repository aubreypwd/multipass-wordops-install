#!/bin/bash

# Install Samba so you can mount and expose /var/www for live editng.

echo "Installing Samba..."

sudo apt update
sudo apt install -y samba

# Add Samba share config
sudo tee -a /etc/samba/smb.conf > /dev/null <<EOF

[www]
   path = /var/www
   available = yes
   valid users = ubuntu
   read only = no
   browsable = yes
   guest ok = yes
EOF

cat /etc/samba/smb.conf

sudo systemctl restart smbd

# Install WordOps...

echo "Installing WordOps..."

# Yes, run bash wo in a sub-shell so it won't exit so the rest below can happen.
wget -qO wo wops.cc && ( sudo bash wo --force )

# You don't have to do sudo so.
echo -e "alias wo='sudo -E wo'" >> "$HOME/.bashrc" && source "$HOME/.bashrc"

echo "Setting dashboard to :666 with no username/password..."

# Setup WordOps
bash -l # autocomplete

# De-secure for local development.
sudo wo secure --auth '' '' # Do not require username/password for dashboard.
sudo wo secure --port 666 # Set port to easy to remember 666.

sudo systemctl restart nginx

echo "Done"
