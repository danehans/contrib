#/bin/bash

set -e

# power cycle servers
/usr/bin/ipmitool -H 10.30.119.14 -U admin -Ppassword power cycle
/usr/bin/ipmitool -H 10.30.119.15 -U admin -Ppassword power cycle
/usr/bin/ipmitool -H 10.30.119.16 -U admin -Ppassword power cycle
/usr/bin/ipmitool -H 10.30.119.17 -U admin -Ppassword power cycle
/usr/bin/ipmitool -H 10.30.119.18 -U admin -Ppassword power cycle
/usr/bin/ipmitool -H 10.30.119.21 -U admin -Ppassword power cycle
/usr/bin/ipmitool -H 10.30.119.22 -U admin -Ppassword power cycle

# clear out ssh keys
/usr/bin/ssh-keygen -R core-master.ctocllab.cisco.com
/usr/bin/ssh-keygen -R core-node01.ctocllab.cisco.com
/usr/bin/ssh-keygen -R core-node02.ctocllab.cisco.com
/usr/bin/ssh-keygen -R core-node04.ctocllab.cisco.com
/usr/bin/ssh-keygen -R core-node05.ctocllab.cisco.com
/usr/bin/ssh-keygen -R core-node07.ctocllab.cisco.com
/usr/bin/ssh-keygen -R core-node08.ctocllab.cisco.com
/usr/bin/ssh-keygen -R core-master
/usr/bin/ssh-keygen -R core-node01
/usr/bin/ssh-keygen -R core-node02
/usr/bin/ssh-keygen -R core-node04
/usr/bin/ssh-keygen -R core-node05
/usr/bin/ssh-keygen -R core-node07
/usr/bin/ssh-keygen -R core-node08
/usr/bin/ssh-keygen -R 10.30.118.82
/usr/bin/ssh-keygen -R 10.30.118.83
/usr/bin/ssh-keygen -R 10.30.118.84
/usr/bin/ssh-keygen -R 10.30.118.85
/usr/bin/ssh-keygen -R 10.30.118.86
/usr/bin/ssh-keygen -R 10.30.118.87
/usr/bin/ssh-keygen -R 10.30.118.88
/usr/bin/ssh-keygen -R 10.30.118.89
/usr/bin/ssh-keygen -R 10.30.118.90
/usr/bin/ssh-keygen -R 10.30.118.91
/usr/bin/ssh-keygen -R 10.30.118.92
