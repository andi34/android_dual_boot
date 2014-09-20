VERSION=$(/sbin/busybox cat /res/misc/version.txt)

set_perm() {
  busybox chown $1.$2 $4
  busybox chmod $3 $4
}

ch_con() {
  busybox chcon u:object_r:system_file:s0 $1
}

if busybox [ ! -f /system/blackhawk-next/release-$VERSION- ]; then
  # Remount system RW
  busybox mount -o remount,rw /system

  # Ensure /system/xbin exists
  busybox mkdir -p /system/xbin
  set_perm 0 0 0755 /system/xbin

  # Ensure /system/etc/init.d exists
  busybox mkdir -p /system/etc/init.d
  set_perm 0 0 0755 /system/etc/init.d

  # su
  busybox rm -f /system/bin/su
  busybox rm -f /system/xbin/su
  busybox rm -f /system/bin/.ext/.su
  # busybox rm -f /system/etc/install-recovery.sh

  busybox mkdir -p /system/bin/.ext
  busybox cp -f /res/misc/su /system/xbin/su
  busybox cp -f /res/misc/su /system/bin/.ext/.su

  set_perm 0 0 0777 /system/bin/.ext
  set_perm 0 0 06755 /system/bin/.ext/.su
  set_perm 0 0 06755 /system/xbin/su

  ch_con /system/bin/.ext/.su
  ch_con /system/xbin/su

  /system/xbin/su --install

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

  # Copy patched Power HAL
  busybox rm -f /system/lib/hw/power.espresso.so
  busybox rm -f /system/lib/hw/power.piranha.so
  busybox mv -f /system/lib/hw/power.default.so /system/lib/hw/power.default.so.bak
  busybox cp -f /res/misc/power.piranha.so /system/lib/hw/power.piranha.so
  set_perm 0 0 0644 /system/lib/hw/power.piranha.so

  # Clean init.d
  cd /system/etc/init.d/
  for f in $(/sbin/busybox ls -a | /sbin/busybox grep -v ^90userinit$); do
    /sbin/busybox rm -f $f
  done
  cd /
  /sbin/busybox rm -f /data/property/persist.customboot.swap

  # Ensure /system/lib/modules exists
  busybox mkdir -p /system/lib/modules
  set_perm 0 0 0755 /system/lib/modules
  
  # Extended kernel modules
  busybox rm -f /system/etc/init.d/02modules
  busybox cp -f /res/misc/02modules /system/etc/init.d/02modules
  set_perm 0 0 0755 /system/etc/init.d/02modules

  # CM userinit
  busybox rm -f /system/etc/init.d/90userinit
  busybox cp -f /res/misc/90userinit /system/etc/init.d/90userinit
  set_perm 0 0 0755 /system/etc/init.d/90userinit
  
  # Post boot script
  busybox rm -f /system/etc/init.sdcard.sh
  busybox rm -f /system/etc/init.post_boot.sh
  busybox cp -f /res/misc/post_boot.sh /system/etc/init.post_boot.sh
  set_perm 0 0 0750 /system/etc/init.post_boot.sh

  # Just in case
  # /sbin/busybox rm -f /system/etc/powervr.ini
  # /sbin/busybox cp -f /system/vendor/etc/powervr.ini /system/etc/powervr.ini
  # /sbin/busybox chown 0.2000 /system/etc/powervr.ini
  # /sbin/busybox chmod 644 /system/etc/powervr.ini

  # Remove unnecessary PowerPV 3D binary if exists
  busybox rm -f /system/vendor/bin/hal_client_test
  busybox rm -f /system/vendor/bin/services_test_SGX540_120
  busybox rm -f /system/vendor/bin/sgx_render_flip_test_SGX540_120
  busybox rm -f /system/vendor/bin/sgx_init_test_SGX540_120
  busybox rm -f /system/vendor/bin/framebuffer_test
  busybox rm -f /system/vendor/bin/texture_benchmark
  busybox rm -f /system/vendor/bin/hal_server_test
  busybox rm -f /system/vendor/bin/testwrap
  busybox rm -f /system/vendor/bin/sgx_flip_test_SGX540_120

  # Force GPU rendering, user can change it anytime
  busybox echo -n true > /data/property/persist.sys.ui.hw
  set_perm 0 0 0600 /data/property/persist.sys.ui.hw

  # Remove old /data/property/persist.customboot.zram
  # Add compcache, zRAM swap per CPU core
  busybox rm -f /data/property/persist.customboot.zram
  busybox cp -f /res/misc/compcache /system/bin/compcache
  set_perm 0 0 0755 /system/bin/compcache

  # Once be enough
  busybox mkdir -p /system/blackhawk-next
  set_perm 0 0 0755 /system/blackhawk-next
  busybox rm /system/blackhawk-next/*
  busybox echo 1 > /system/blackhawk-next/release-$VERSION-

  # Remount system RO
  busybox sync
  busybox mount -o remount,ro /system
fi;
