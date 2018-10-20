#!/bin/bash
#
#https://ineed.coffee/3838/a-beginners-tutorial-for-mbpfan-under-ubuntu/
#
if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root type: sudo ./installscript"
   	exit 1
else

#Setup Dependancies
echo "Ensure dependancies are installed..."
apt install -y make git build-essential

clear
#Get the ideal fan & temperature settings for this Macbook
cd /sys/devices/platform/applesmc.768/
FANMIN=$(cat fan*_min)
echo "Minimum fan speed is $FANMIN"
FANMAX=$(cat fan*_max)
echo "Maximum fan speed is $FANMAX"
MAXTEMP=$(cat /sys/devices/platform/coretemp.*/hwmon/hwmon*/temp3_max)
TEMPMAX=$((MAXTEMP / 1000))
echo "Maximum Macbook temperature is $TEMPMAX"
echo
#Install Macbook Fan
echo "**********************************"
echo "Installing Mackbook Fan service..."
echo "**********************************"
cd /tmp
#Download the source code
git clone https://github.com/dgraziotin/mbpfan.git
cd mbpfan
make
make install
#Test the mbpfan software
./bin/mbpfan -t
#Add the values we got earlier to the service file
#Set the config file location
CONFIG="/etc/mbpfan.conf"
#Use sed to set the new config file values...
function set_config(){
    sed -i.bak "s/[#{1,}]\($1\s* = \s*\).*\$/\1$2/" $CONFIG
    sed -i.bak "s/^\($1\s* = \s*\).*\$/\1$2/" $CONFIG
}
source $CONFIG
set_config min_fan_speed $FANMIN
set_config max_fan_speed $FANMAX
set_config max_temp $TEMPMAX
cat /etc/mbpfan.conf
#Setup to run at startup...
cp mbpfan.service /etc/systemd/system/
systemctl enable mbpfan.service
systemctl daemon-reload
systemctl start mbpfan.service
#remove the source files
cd ..
rm -r -f mbpfan
#check the status
systemctl status mbpfan.service
echo
echo "Install complete!"
echo
fi
