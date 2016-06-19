#!/bin/bash

# Usage: ./deploy.sh [host]
host="centos@52.48.83.232"

if [ -z "$host" ]; then
    echo "Please provide a host - eg: ./deploy root@my-server.com"
    exit 1
fi

echo "deploying to ${host}"
#
# # The host key might change when we instantiate a new VM, so
# # we remove (-R) the old host key from known_hosts
ssh-keygen -R "${host#*@}" 2> /dev/null
#
# # rough test for what distro the server is on
DISTRO=`ssh -i ~/.ssh/qbx-central -o 'StrictHostKeyChecking no' ${host} 'bash -s' < bootstrap.sh`

echo $DISTRO
if [ "$DISTRO" == "FED" ]; then
    echo "Detected a Fedora, RHEL, CentOS distro on host"

    tar cjh . | ssh -i ~/.ssh/qbx-central -o 'StrictHostKeyChecking no' "$host" '
    sudo rm -rf /tmp/chef &&
    mkdir /tmp/chef &&
    cd /tmp/chef &&
    tar xj &&
    sudo bash install.sh &&
    echo Done Installing.
'
elif [ "$DISTRO" == "DEB" ]; then
  echo Skipping Installation.
fi
