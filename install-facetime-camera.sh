#!/bin/bash
KERNELRELEASE=$(uname -r)

echo "Installing FacetimeHD camera for $KERNELRELEASE"
cd /tmp
git clone https://github.com/patjak/bcwc_pcie.git
cd bcwc_pcie
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
  cat > "/etc/modules-load.d/facetimehd.conf" << EOL
  #videobuf2-core
  #videobuf2_v4l2
  #videobuf2-dma-sg
  facetimehd
  EOL
fi

echo "Install complete!"
