

For our infrastructure in Stratos Datacenter we have a requirement to serve our website code from a common/shared location that can be shared among all app nodes. For this we came up with a solution to use NFS (Network File System) server that can store the data and we can mount the share among our app nodes. The dedicated NFS server going to be our storage server. To accomplish this task do the following given steps:


1 Install required NFS packages on storage server.

2 Configure storage server to act as an NFS server.

3 Make a NFS share /webdata on storage server.

4 Install and configure NFS client packages on all app nodes and configure them to act as NFS client.

5 Mount /webdata directory on all app nodes at /var/www/opt directory (Create the directories if don't exist).

6 Start and enable required services.


yum install nfs-utils rpcbind
mkdir /webdata
vi /etc/exports
/opt/nfs ip(no_root_squash,rw,sync)

service rpcbind start; service nfs start
service nfs status

nfs client configuration
yum install nfs-utils rpcbind
service rpcbind start

[nfs-server ]# systemctl enable nfs-server
ln -s '/usr/lib/systemd/system/nfs-server.service' '/etc/systemd/system/nfs.target.wants/nfs-server.service'

[nfs-client ]# mkdir -p /mnt/nfs
[ nfs-client ]# mount 10.1.1.110:/opt/nfs /mnt/nfs/
perm mount: /etc/fstab
10.1.1.110:/opt/nfs	/mnt/nfs	nfs	defaults 		0 0
