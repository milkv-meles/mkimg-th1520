#!/bin/bash

# use all emmc free space for rootfs
parted -s /dev/mmcblk0 "resizepart 4 -0"

# refresh filesystem usable size
resize2fs /dev/mmcblk0p2
resize2fs /dev/mmcblk0p4

# formatand enable swap partition
mkswap /dev/mmcblk0p3
swapon -a

# regenerate fstab
genfstab -t PARTUUID / > /etc/fstab

# regenerate openssh host keys
dpkg-reconfigure openssh-server

# update initramfs for init
update-initramfs -c -k all

# reboot
reboot
