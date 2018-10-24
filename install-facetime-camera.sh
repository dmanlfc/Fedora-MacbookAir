#!/bin/bash
KERNELRELEASE=$(uname -r)

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root type: sudo ./installscript"
  exit 1
else

  #Setup Dependancies
  echo "Ensure dependancies are installed..."
  dnf install -y make gitv curl xzcat cpio kernel-devel

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

  #check directory exists
  if [ ! -d "/etc/modules-load.d" ]; then
    echo "Creating modules-load.d directory..."
    mkdir -p "/etc/modules-load.d"
  fi
  
  #check file exists
  if [ ! -d "/etc/modules-load.d/facetimehd.conf" ]; then
    echo "Creating FaceTimeHD config file..."
    echo > "/etc/modules-load.d/facetimehd.conf" facetimehd
  fi
  echo "**************************************"
  echo "* FaceTime HD installation complete! *"
  echo "**************************************"
fi
