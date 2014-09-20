#!/sbin/busybox sh

if [ ! -f /data/.blackhawk/efsbackup.tar.gz ];
then
  mkdir -p /data/.blackhawk
  chmod 777 /data/.blackhawk
  /sbin/busybox tar zcvf /data/.blackhawk/efsbackup.tar.gz /efs
  /sbin/busybox cat /dev/block/mmcblk0p1 > /data/.blackhawk/efsdev-mmcblk0p1.img
  /sbin/busybox gzip /data/.blackhawk/efsdev-mmcblk0p1.img
  /sbin/busybox cp /data/.blackhawk/efs* /data/media
  chmod 777 /data/media/efsdev-mmcblk0p1.img
  chmod 777 /data/media/efsbackup.tar.gz
fi
