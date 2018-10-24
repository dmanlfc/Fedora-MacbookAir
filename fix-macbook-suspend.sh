#!/bin/bash
#fix suspend on the Macbook Air
cat > "/etc/systemd/sleep.conf" << EOL
[Sleep]
# Suspend to RAM (S3)
SuspendMode=suspend
SuspendState=mem
# Hibernate (hybrid-sleep) mem & disk
HibernateMode=suspend
HibernateState=disk
EOL
