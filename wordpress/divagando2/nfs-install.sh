#!/bin/bash

NFS_NETWORK="192.168.123.0/24"
NFS_SHARE="/srv/nfs/docker-stor"

dnf install -y nfs-utils

mkdir -p "${NFS_SHARE}"
chown nobody:nobody "${NFS_SHARE}"
chmod 777 "${NFS_SHARE}"

echo "${NFS_SHARE} ${NFS_NETWORK}(rw,async,no_wdelay,no_subtree_check,no_root_squash,sec=sys)
" >> /etc/exports

systemctl enable --now nfs-server
systemctl enable --now rpcbind

firewall-cmd  --permanent --add-service={nfs,rpcbind,mountd}
firewall-cmd --reload
exportfs -ra
exportfs -v

