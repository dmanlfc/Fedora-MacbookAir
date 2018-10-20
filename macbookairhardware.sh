#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root type: sudo ./installscript"
   	exit 1
else

#Update and Upgrade
echo "*****************************************"
echo "* Updating and upgrading your system... *"
echo "*****************************************"
apt update && apt -y upgrade

#Installing the hardware drivers
chmod +x *.sh
echo "Installing the FaceTime HD web camera"
./install-camera-elementary5.sh
echo "Install the Broadcom WiFi driver"
./install-macbookair-wifi-elementary5.sh
echo "Ensure the fan drivers are installed"
./install-macbookfan-elementary5.sh

echo "****************************"
echo "* Removing old packages... *"
echo "****************************"
apt -y autoremove
echo "********************************"
echo "* DONE! Ideally reboot your PC *"
echo "********************************"
fi
