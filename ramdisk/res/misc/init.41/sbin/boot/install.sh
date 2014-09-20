VERSION=$(/sbin/busybox cat /res/misc/version.txt)

if /sbin/busybox [ ! -f /system/blackhawk-next/release-$VERSION- ]; then
  # Remount system RW
  /sbin/busybox mount -o remount,rw /system

  # Ensure /system/xbin exists
  /sbin/busybox mkdir -p /system/xbin
  /sbin/busybox chmod 755 /system/xbin

  # Ensure /system/etc/init.d exists
  /sbin/busybox mkdir -p /system/etc/init.d
  /sbin/busybox chmod 755 /system/etc/init.d

  # su
  /sbin/busybox rm -f /system/bin/su
  /sbin/busybox cp -f /res/misc/su /system/xbin/su
  /sbin/busybox chown 0.0 /system/xbin/su
  /sbin/busybox chmod 6755 /system/xbin/su

  # Superuser
  # /sbin/busybox rm -f /system/app/SuperUser.apk
  # /sbin/busybox rm -rf /data/data/com.noshufou.android.su
  # /sbin/busybox rm -f /data/dalvik-cache/*com.noshufou.android.su-*.apk*
  # /sbin/busybox rm -f /data/dalvik-cache/*SuperUser.apk*
  # if [ ! -e /system/app/Superuser.apk ]; then
  #   /sbin/busybox rm -rf /data/data/eu.chainfire.supersu
  #   /sbin/busybox rm -f /data/dalvik-cache/*eu.chainfire.supersu-*.apk*
  #   /sbin/busybox rm -f /data/dalvik-cache/*Superuser.apk*
  # fi
  # /sbin/busybox rm -f /data/app/Superuser.apk
  # /sbin/busybox cp -f /res/misc/Superuser.apk /system/app/Superuser.apk
  # /sbin/busybox chown 0.0 /system/app/Superuser.apk
  # /sbin/busybox chmod 644 /system/app/Superuser.apk

  # Clean init.d
  cd /system/etc/init.d/
  for f in $(/sbin/busybox ls -a | /sbin/busybox grep -v ^90userinit$); do
    /sbin/busybox rm -f $f
  done
  cd /
  /sbin/busybox rm -f /data/property/persist.customboot.swap

  # Extended kernel modules
  /sbin/busybox rm -f /system/etc/init.d/02modules
  /sbin/busybox cp -f /res/misc/02modules /system/etc/init.d/02modules
  /sbin/busybox chown 0.0 /system/etc/init.d/02modules
  /sbin/busybox chmod 755 /system/etc/init.d/02modules

  # CM userinit
  /sbin/busybox rm -f /system/etc/init.d/90userinit
  /sbin/busybox cp -f /res/misc/90userinit /system/etc/init.d/90userinit
  /sbin/busybox chown 0.0 /system/etc/init.d/90userinit
  /sbin/busybox chmod 755 /system/etc/init.d/90userinit
  
  # Post boot script
  /sbin/busybox rm -f /system/etc/init.sdcard.sh
  /sbin/busybox rm -f /system/etc/init.post_boot.sh
  /sbin/busybox cp -f /res/misc/post_boot.sh /system/etc/init.post_boot.sh
  /sbin/busybox chown 0.0 /system/etc/init.post_boot.sh
  /sbin/busybox chmod 750 /system/etc/init.post_boot.sh

  # Just in case
  # /sbin/busybox rm -f /system/etc/powervr.ini
  # /sbin/busybox cp -f /system/vendor/etc/powervr.ini /system/etc/powervr.ini
  # /sbin/busybox chown 0.2000 /system/etc/powervr.ini
  # /sbin/busybox chmod 644 /system/etc/powervr.ini

  # Remove unnecessary PowerPV 3D binary if exists
  /sbin/busybox rm -f /system/vendor/bin/hal_client_test
  /sbin/busybox rm -f /system/vendor/bin/services_test_SGX540_120
  /sbin/busybox rm -f /system/vendor/bin/sgx_render_flip_test_SGX540_120
  /sbin/busybox rm -f /system/vendor/bin/sgx_init_test_SGX540_120
  /sbin/busybox rm -f /system/vendor/bin/framebuffer_test
  /sbin/busybox rm -f /system/vendor/bin/texture_benchmark
  /sbin/busybox rm -f /system/vendor/bin/hal_server_test
  /sbin/busybox rm -f /system/vendor/bin/testwrap
  /sbin/busybox rm -f /system/vendor/bin/sgx_flip_test_SGX540_120

  # Force GPU rendering, user can change it anytime
  /sbin/busybox echo -n true > /data/property/persist.sys.ui.hw
  /sbin/busybox chmod 600 /data/property/persist.sys.ui.hw

  # Remove old /data/property/persist.customboot.zram
  # Add compcache, zRAM swap per CPU core
  /sbin/busybox rm -f /data/property/persist.customboot.zram
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
