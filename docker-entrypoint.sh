#!/bin/sh
trap "/etc/init.d/hpcc-init stop && service dafilesrv stop" INT TERM KILL
# ^ stop the services on receiving the signals

# regenerate keys
/usr/bin/ssh-keygen -A

# fork daemon to background
/usr/sbin/sshd -D &


# start the service
/etc/init.d/hpcc-init start


# wait for children to return -> aka an infinite loop
wait
