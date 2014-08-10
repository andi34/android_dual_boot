#!/sbin/busybox sh

/sbin/busybox sh /sbin/boot/install.sh
/sbin/busybox sh /sbin/boot/tweaks.sh

busybox mount -o remount,rw /
busybox rm -f /res/misc/*
busybox rmdir /res/misc
busybox mount -o remount,ro /

read sync < /data/sync_fifo
rm /data/sync_fifo

setprop blackhawk_next.ready 1
