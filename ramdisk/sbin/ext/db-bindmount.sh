#!/sbin/busybox sh

/sbin/busybox mkdir -p /.secondrom/media/.secondrom/data
/sbin/busybox mount --bind /.secondrom/media/.secondrom/data /data
/sbin/busybox mkdir -p /data/media
/sbin/busybox mount --bind /.secondrom/media /data/media
