#!/bin/bash
#Download the source code
git clone https://github.com/dgraziotin/mbpfan.git
#Move to working directory
cd mbpfan
#Make & Install the code
make
sudo make install
#Test the mbpfan software
sudo ./bin/mbpfan -t
#Setup to run at startup...
sudo cp mbpfan.service /etc/systemd/system/
sudo systemctl enable mbpfan.service
sudo systemctl daemon-reload
sudo systemctl start mbpfan.service
#remove the source files
cd ..
rm -r -f mbpfan
#check the status
#sudo systemctl status mbpfan.service
