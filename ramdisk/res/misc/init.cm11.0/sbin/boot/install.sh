if busybox [ ! -f /system/blackhawk-next/release-12- ]; then
  # Remount system RW
  busybox mount -o remount,rw /system

  # Clean init.d
  # cd /system/etc/init.d/
  # for f in $(busybox ls -a | busybox grep -v ^00banner$ | busybox grep -v ^90userinit$); do
  #   busybox rm -f $f
  # done
  # cd /

  # Extended kernel modules
  busybox rm -f /system/etc/init.d/02modules
  busybox cp -f /res/misc/02modules /system/etc/init.d/02modules
  busybox chown 0.0 /system/etc/init.d/02modules
  busybox chmod 755 /system/etc/init.d/02modules

  # Once be enough
  busybox mkdir -p /system/blackhawk-next
  busybox chmod 755 /system/blackhawk-next
  busybox rm /system/blackhawk-next/*
  echo 1 > /system/blackhawk-next/release-12-

  # Remount system RO
  busybox sync
  busybox mount -o remount,ro /system
fi;
