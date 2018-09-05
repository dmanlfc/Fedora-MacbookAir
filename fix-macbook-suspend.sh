#!/bin/bash
#fix suspend on the Macbook Air
cat > "/etc/systemd/sleep.conf" << EOL
[Sleep]
# Suspend to RAM
SuspendMode=suspend
SuspendState=mem
EOL
