#!/bin/bash
#Setup Dependancies
KERNELRELEASE=$(uname -r)

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root type: sudo ./installscript"
   	exit 1
else

echo "Ensure dependancies are installed..."
apt install -y make
apt install -y linux-headers-$KERNELRELEASE git kmod libssl-dev checkinstall libelf-dev
apt install -y curl xzcat cpio

clear
#Install Factime Camera
echo "**************************************************"
echo "Installing FacetimeHD camera for $KERNELRELEASE"
echo "**************************************************"
cd /tmp
git clone https://github.com/patjak/bcwc_pcie.git
cd bcwc_pcie/firmware
make
make install
cd ..
make
make install
depmod
modprobe facetimehd
rm -rf /tmp/bcwc_pcie

if [ ! -d "/etc/modules-load.d" ]; then
  echo "Creating modules-load.d directory..."
  mkdir -p "/etc/modules-load.d"
fi

if [ ! -d "/etc/modules-load.d/facetimehd.conf" ]; then
  echo "Creating FaceTimeHD config file..."
  echo > "/etc/modules-load.d/facetimehd.conf" facetimehd
fi
echo
echo "Install complete!"
echo
fi
