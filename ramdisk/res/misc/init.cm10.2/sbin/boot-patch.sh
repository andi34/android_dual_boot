#!/sbin/busybox sh

/sbin/busybox sh /sbin/ext/post-init.sh
/sbin/busybox sh /sbin/boot/install.sh
# /sbin/busybox sh /sbin/boot/rotate.sh
/sbin/busybox sh /sbin/boot/tweaks.sh

/sbin/busybox mount -o remount,rw /
/sbin/busybox rm -f /res/misc/*
/sbin/busybox mount -o remount,ro /

read sync < /data/sync_fifo
rm /data/sync_fifo

setprop blackhawk_next.ready 1
