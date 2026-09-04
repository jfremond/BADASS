#!/usr/bin/bash

set -x

export DEBIAN_FRONTEND=noninteractive

# Update and install desktop env
apt-get update
apt-get install -y gnome-shell ubuntu-desktop

# Add GNS3 PPA
apt-get install -y software-properties-common
add-apt-repository -y ppa:gns3/ppa
apt-get update

# Non interactive perms
echo "ubridge ubridge/install-setuid boolean true" | debconf-set-selections
echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections

# Install GNS3 and tools
apt-get install -y gns3-gui ubridge wireshark docker.io

# Create wireshark group
groupadd -f wireshark

# Add user to groups
usermod -aG docker,ubridge,wireshark vagrant

# Give rights for packet capture
chgrp vagrant /usr/bin/dumpcap
chmod 754 /usr/bin/dumpcap
setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
