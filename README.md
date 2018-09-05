# Fedora-MacbookAir
A set of driver scripts I use to make my Macbook Air 7,2 (2015) run Fedora 28

## 99-install-broadcom-wifi.sh
Downloads the RPM Fusion repo & installs the Broadcom Wirless LAN driver

## 99-install-facetime-camera.sh
Downloads the source code for the Facetime HD camera
Installs the software & sets up the Kernel for use.

## 99-install-macbook-fan.sh
Downloads the Macbook Fan controll source code
Installs & creates service that runs on boot

## fix-macbook-suspend.sh
For some reason the Macbook Air doesn't resume from Standby sometimes.
Typically this is after long periods of time.
Forcing Standby to use S3 (although it does anyway) seems to fix it
*** In review ***
