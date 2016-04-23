#!/bin/bash

DEV=/dev/ttyUSB0

test -e ${DEV} && chown frickler:frickler ${DEV}
cd /data/
exec su -c /bin/bash frickler
