#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root type: sudo ./installscript"
   	exit 1
else
  #fix suspend on the Macbook Air
  echo "**********************************"
  echo "* Fixing Macbook Suspend (S3)... *"
  echo "**********************************"
  cat > "/etc/systemd/sleep.conf" << EOL
  [Sleep]
  # Suspend to RAM (S3)
  SuspendMode=suspend
  SuspendState=mem
  # Hibernate (hybrid-sleep) mem & disk
  HibernateMode=suspend
  HibernateState=disk
  EOL
fi
