#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root type: sudo ./installscript"
   	exit 1
else

  #Update and Upgrade
  echo "*****************************************"
  echo "* Updating and upgrading your system... *"
  echo "*****************************************"
  dnf -y update

  #Installing the hardware drivers
  chmod +x *.sh
  echo "*****************************************"
  echo "* Installing the FaceTime HD web camera *"
  echo "*****************************************"
  ./install-facetime-camera.sh
  echo "************************************"
  echo "* Install the Broadcom WiFi driver *"
  echo "************************************"
  ./install-broadcom-wifi.sh
  echo "****************************************"
  echo "* Ensure the fan drivers are installed *"
  echo "****************************************"
  ./install-macbook-fan.sh
  echo "*****************************************"
  echo "* Ensure the system standby's correctly *"
  echo "*****************************************"
  ./fix-macbook-suspend.sh

  echo "********************************"
  echo "* DONE! Ideally reboot your PC *"
  echo "********************************"
fi
