# Odroid 1

## Root and Home Setup

SSD for root, nix store, home
HDD for audiobooks, movies, nextcloud files

## Become root

`sudo su`

## Setup Variables

`DISK=/dev/disk/by-id/nvme-WDS`

> Hit `tab`, pick the right one

`POOL=rpool`

`MY_USER=iancleary`

## Wipe Disks

<https://blog.trentsonlinedocs.xyz/posts/faster-partitioning-with-sgdisk/>

Wipe any leftover filesystem metadata with wipefs.

`wipefs --all $DISK`

Create a new GPT partition table.

`sgdisk $DISK -o`

Create an efi partition of 512MB by specifying the end of the partition (relative) and the partition type, ef00.

`sgdisk $DISK -n 1::+1024MiB -t 1:ef00`

Create an / partition using the remainder of the disk, by not specifying the end or the beginning or partition type, which defaults to 8300.

`sgdisk $DISK -n 2`

List partitions

`lsblk`

Format the efi partition fat 32.

`mkfs.vfat -F32 /dev/nvme0n1p1`

<https://grahamc.com/blog/erase-your-darlings/>

### Datasets

The remainder of the disk is managed by ZFS split into the following datasets:

- /local - dataset for mounting /nix/store. It is not snapshotted since the nix store can be trivially repopulated/rebuilt if the data is lost or corrupted

- /reserved - A 100 GiB reserved partition to act as an over-provisioning guard and preserve the SSD performance (SSDs avoid wearing out individual blocks by moving writes around. But if the drive fills up, the speed and health of the drive will decrease. By never mounting this dataset, and asking ZFS to ensure there is always 100 GiB available for it, I'm effecitvely capping the disk at 90%).

- /system - dataset for mounting /root and /var. This dataset is regularly snapshotted so I can rollback in case something catastrophic happens. I have not yet decided to erase my darlings but if I do I would move my /root mount...

- /user - dataset for storing user home directories, regularly snapshotted

## Create pool

```bash
zpool create "${POOL}" nvme0n1p2 -f
```

### Enable autotrim to maintain SSD performance

```bash
zpool set autotrim=on "${POOL}"
```

## Create datasets

### My choice of datasets

```bash
zfs create -o compression=on -o mountpoint=legacy "${POOL}/local"
zfs create -p -o compression=on -o mountpoint=legacy "${POOL}/safe/system"
zfs create -p -o compression=on -o mountpoint=legacy "${POOL}/safe/home"
zfs create -o compression=on -o mountpoint=legacy "${POOL}/reserved"
```

```bash
zfs create -o xattr=sa -o acltype=posixacl "${POOL}/safe/system/var"
zfs create "${POOL}/safe/system/root"
zfs create "${POOL}/safe/home/${MY_USER}"
zfs create "${POOL}/local/nix"
```

## Set a quota on reserved

```bash
zfs set reservation=100G "${POOL}/reserved"
zfs set quota=100G "${POOL}/reserved"
# ensure we can't accidentally write more than 100G to this partition
```

## Setup snapshotting
```bash
zfs set com.sun:auto-snapshot=true "${POOL}/safe/system"
zfs set com.sun:auto-snapshot=true "${POOL}/safe/home"
```

```bash
# Mount the root partition itself
mount -t zfs "${POOL}/safe/system/root" /mnt

# Make directory entries for the subsequent mounts
mkdir -p /mnt/boot
mkdir -p /mnt/nix
mkdir -p /mnt/var
mkdir -p "/mnt/home/${MY_USER}"

# Mount the boot partition
sudo mount /dev/nvme0n1p1 /mnt/boot

# Mount the rest of our zfs datasets
mount -t zfs "${POOL}/local/nix" /mnt/nix
mount -t zfs "${POOL}/safe/system/var" /mnt/var
mount -t zfs "${POOL}/safe/home/${MY_USER}" "/mnt/home/${MY_USER}"
```

# Data Pool Setup


SSD for root, nix store, home
HDD for audiobooks, movies, nextcloud files

```bash

zpool list
ls -lah /dev/disk/by-id
sudo zpool create -f -o ashift=12 -m /dpool dpool mirror ata-ST4000NE001-2MA101_WS24QMP8 ata-ST4000NE001-2MA101_WS227C59
zpool list

sudo zpool set cachefile=/etc/zfs/zpool.cache dpool                                                                    
sudo systemctl enable zfs.target
sudo zfs set relatime=on dpool
sudo zfs set compression=lz4 dpool

sudo zfs create dpool/audiobookshelf
sudo zfs create dpool/homeassistant
sudo zfs create dpool/jellyfin
sudo zfs create dpool/nextcloud
sudo zfs create dpool/s-pdf
sudo zfs create dpool/unifi
```

## Migration 

When I migrated from `~/Containers`

```bash
sudo rsync -avu --delete "/home/iancleary/Containers/unifi/" "/dpool/audiobookshelf/"
sudo rsync -avu --delete "/home/iancleary/Containers/unifi/" "/dpool/homeassistant/"
sudo rsync -avu --delete "/home/iancleary/Containers/unifi/" "/dpool/jellyfin/"
sudo rsync -avu --delete "/home/iancleary/Containers/unifi/" "/dpool/s-pdf/"
sudo rsync -avu --delete "/home/iancleary/Containers/unifi/" "/dpool/unifi/"
```


# NixOS installation

Finally it's time to get nix involved! Run the generation command below and
it should do a good job at auto-detecting any hardware and filesystem configurations

```bash
nixos-generate-config --root /mnt
```

> Copy from gist!

```bash
nixos-install --no-root-passwd
```