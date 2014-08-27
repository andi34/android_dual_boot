#!/sbin/busybox sh

/sbin/busybox mount -t tmpfs tmpfs /system/lib/modules
/sbin/busybox ln -s /lib/modules/* /system/lib/modules
