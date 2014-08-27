#!/sbin/busybox sh

busybox mkdir -p /.secondrom/media/.secondrom/data
busybox mount --bind /.secondrom/media/.secondrom/data /data
busybox mkdir -p /data/media
busybox mount --bind /.secondrom/media /data/media
