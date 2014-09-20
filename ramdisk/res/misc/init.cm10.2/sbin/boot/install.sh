VERSION=$(/sbin/busybox cat /res/misc/version.txt)

if /sbin/busybox [ ! -f /system/blackhawk-next/release-$VERSION- ]; then
  # Remount system RW
  /sbin/busybox mount -o remount,rw /system

  # Ensure /system/etc/init.d exists
  /sbin/busybox mkdir -p /system/etc/init.d
  /sbin/busybox chmod 755 /system/etc/init.d

  # Copy patched Power HAL
  /sbin/busybox rm -f /system/lib/hw/power.espresso.so
  /sbin/busybox rm -f /system/lib/hw/power.piranha.so
  /sbin/busybox cp -f /res/misc/power.piranha.so /system/lib/hw/power.piranha.so
  /sbin/busybox chown 0.0 /system/lib/hw/power.piranha.so
  /sbin/busybox chmod 644 /system/lib/hw/power.piranha.so

  # Remove old init.d script, HIDDEN partition /dev/block/mmcblk0p11 as swap device
  # will break 2nd ROM /cache partition
  cd /system/etc/init.d/
  for f in $(/sbin/busybox ls -a | /sbin/busybox grep -v ^00banner$ | /sbin/busybox grep -v ^90userinit$); do
    /sbin/busybox rm -f $f
  done
  cd /
  /sbin/busybox rm -f /data/property/persist.customboot.swap

  # Extended kernel modules
  /sbin/busybox rm -f /system/etc/init.d/02modules
  /sbin/busybox cp -f /res/misc/02modules /system/etc/init.d/02modules
  /sbin/busybox chown 0.0 /system/etc/init.d/02modules
  /sbin/busybox chmod 755 /system/etc/init.d/02modules

  # Post boot script
  /sbin/busybox rm -f /system/etc/init.post_boot.sh
  /sbin/busybox cp -f /res/misc/post_boot.sh /system/etc/init.post_boot.sh
  /sbin/busybox chown 0.0 /system/etc/init.post_boot.sh
  /sbin/busybox chmod 750 /system/etc/init.post_boot.sh

  # Just in case
  # /sbin/busybox rm -f /system/etc/powervr.ini
  # /sbin/busybox cp -f /system/vendor/etc/powervr.ini /system/etc/powervr.ini
  # /sbin/busybox chown 0.2000 /system/etc/powervr.ini
  # /sbin/busybox chmod 644 /system/etc/powervr.ini

  # Remove unnecessary PowerPV 3D library
  # /sbin/busybox rm -f /system/vendor/bin/pvrsrvctl_SGX544_112
  # /sbin/busybox rm -f /system/vendor/lib/egl/libEGL_POWERVR_SGX544_112.so
  # /sbin/busybox rm -f /system/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX544_112.so
  # /sbin/busybox rm -f /system/vendor/lib/egl/libGLESv2_POWERVR_SGX544_112.so
  # /sbin/busybox rm -f /system/vendor/lib/hw/gralloc.omap4460.so
  # /sbin/busybox rm -f /system/vendor/lib/hw/gralloc.omap4470.so
  # /sbin/busybox rm -f /system/vendor/lib/libglslcompiler_SGX544_112.so
  # /sbin/busybox rm -f /system/vendor/lib/libIMGegl_SGX544_112.so
  # /sbin/busybox rm -f /system/vendor/lib/libpvr2d_SGX544_112.so
  # /sbin/busybox rm -f /system/vendor/lib/libpvrANDROID_WSEGL_SGX544_112.so
  # /sbin/busybox rm -f /system/vendor/lib/libPVRScopeServices_SGX544_112.so
  # /sbin/busybox rm -f /system/vendor/lib/libsrv_init_SGX544_112.so
  # /sbin/busybox rm -f /system/vendor/lib/libsrv_um_SGX544_112.so
  # /sbin/busybox rm -f /system/vendor/lib/libusc_SGX544_112.so

  # CM performance property, user can change it anytime
  /sbin/busybox echo -n 1 > /data/property/persist.sys.purgeable_assets
  /sbin/busybox echo -n 1 > /data/property/persist.sys.use_16bpp_alpha
  /sbin/busybox echo -n 0 > /data/property/persist.sys.use_dithering
  /sbin/busybox chmod 600 /data/property/persist.sys.purgeable_assets
  /sbin/busybox chmod 600 /data/property/persist.sys.use_16bpp_alpha
  /sbin/busybox chmod 600 /data/property/persist.sys.use_dithering

  # Force GPU rendering, user can change it anytime
  /sbin/busybox echo -n true > /data/property/persist.sys.ui.hw
  /sbin/busybox chmod 600 /data/property/persist.sys.ui.hw

  # Update CM compcache, zRAM swap per CPU core
  if [ ! -e /system/bin/compcache.backup ]; then
    /sbin/busybox mv -f /system/bin/compcache /system/bin/compcache.backup
  fi
  /sbin/busybox cp -f /res/misc/compcache /system/bin/compcache
  /sbin/busybox chmod 755 /system/bin/compcache

  # Once be enough
  /sbin/busybox mkdir -p /system/blackhawk-next
  /sbin/busybox chmod 755 /system/blackhawk-next
  /sbin/busybox rm /system/blackhawk-next/*
  echo 1 > /system/blackhawk-next/release-$VERSION-

  # Remount system RO
  /sbin/busybox sync
  /sbin/busybox mount -o remount,ro /system
fi;
