#!/bin/bash

# Create the directories used for Docker bind mounting
mkdir -p /opt/bin/
#mkdir -p /tmp/.ansible/files/
mkdir -p /tmp/
mkdir -p /etc/etcd/
mkdir -p /etc/kubernetes/
mkdir -p /etc/systemd/system/
mkdir -p /usr/lib64/systemd/system/
mkdir -p /usr/bin/systemctl/
mkdir -p /etc/sysconfig/

# Make sure Docker is running
/usr/bin/systemctl enable docker.service
/usr/bin/systemctl start docker.service

# Create the Python binary
cat > /opt/bin/python <<EOF
#!/bin/sh

tty > /dev/null 2>&1 && ttyflag='-t'
exec docker run -i --rm -v /opt/bin:/opt/bin \
-v /etc/lsb-release:/etc/lsb-release \
-v /etc/etcd/:/etc/etcd \
-v /etc/kubernetes:/etc/kubernetes \
-v /etc/systemd/system:/etc/systemd/system \
-v /usr/lib64/systemd/system:/usr/lib64/systemd/system \
-v /usr/bin/systemctl:/usr/bin/systemctl \
-v /home/core:/home/core \
-v /etc/sysconfig:/etc/sysconfig \
-v /tmp:/tmp \
-v /usr/sbin/groupadd:/usr/sbin/groupadd \
-v /usr/sbin/useradd \
\$ttyflag --net=host python:2.7.11-alpine python "\$@"
EOF

sudo chmod +x /opt/bin/python
