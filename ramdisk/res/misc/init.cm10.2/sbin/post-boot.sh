#!/sbin/busybox sh

/sbin/busybox sh /system/etc/init.post_boot.sh
busybox mount -o remount,noatime,nodiratime /system
