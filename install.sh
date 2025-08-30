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

IP=$(hostname -I | awk '{print $1}')

echo "Setting dashboard to http://$IP:666 with no admin/password..."

# Setup WordOps
bash -l # autocomplete

# We have to create a site for all the below to work.
( sudo wo site create --html wordops )

echo "Securing :666 with admin:password..."

( sudo wo secure --auth 'admin' 'password' ) # Simple username/password.
( sudo wo secure --port 666 ) # Set port to easy to remember 666.

echo "Installing stacks..."

( sudo wo stack install --dashboard ) # Install the dashboard.
( sudo wo stack install --adminer )
( sudo wo stack install --wpcli )
( sudo wo stack install --utils )

echo "Done"
echo "- Add $IP wordops to host's /etc/hosts"
echo "- Then goto http://wordops/:666 or http://default/"
