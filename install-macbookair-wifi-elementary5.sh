#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root type: sudo ./installscript"
   	exit 1
else

clear
#Install Macbook Air Broadcom Wifi
echo "*******************************"
echo "Installing Mackbook Air Wifi..."
echo "*******************************"
apt install -y bcmwl-kernel-source
modprobe wl
echo
echo "Install complete!"
echo
fi
