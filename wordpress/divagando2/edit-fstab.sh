#!/bin/bash

NFS_SERVER="192.168.123.150"
NFS_SHARE="/srv/nfs/docker-stor"
MOUNT_POINT="/mnt/nfs/docker-stor"
MOUNT_OPTS="rw,async,hard,intr,noatime,nodiratime,rsize=32768,wsize=32768,timeo=15,retrans=2,_netdev"

dnf install -y nfs-utils

sudo mkdir -p "${MOUNT_POINT}"
echo "${NFS_SERVER}:${NFS_SHARE} ${MOUNT_POINT} nfs ${MOUNT_OPTS} 0 0" | sudo tee -a /etc/fstab
sudo mount -a
