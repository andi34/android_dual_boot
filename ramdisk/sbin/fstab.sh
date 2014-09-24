#!/sbin/busybox sh

# Ketut P. Kumajaya, Sept 2014
# Do not remove above credits header!

# Usage: fstab.sh [0|1] [miui|cm110|cm102|cm101|sammy41|sammy42]

EXT4OPT="noatime,nosuid,nodev,discard,noauto_da_alloc,journal_async_commit,errors=panic    wait,check"
F2FSOPB="background_gc=off,inline_xattr,active_logs=2    wait"
F2FSOPT="noatime,nosuid,nodev,discard,$F2FSOPB"

# Galaxy Tab 2 P31XX / P51XX spesific config
FSTAB=/fstab.espresso

SYSTEMDEV="\
/dev/block/platform/omap/omap_hsmmc.1/by-name/FACTORYFS "
DATADEV="\
/dev/block/platform/omap/omap_hsmmc.1/by-name/DATAFS    "
CACHEDEV="\
/dev/block/platform/omap/omap_hsmmc.1/by-name/CACHE     "
HIDDENDEV="\
/dev/block/platform/omap/omap_hsmmc.1/by-name/HIDDEN    "; # Same as CACHEDEV for a common /cache

EFS="\
/dev/block/platform/omap/omap_hsmmc.1/by-name/EFS         /efs           ext4    nodiratime,$EXT4OPT"

CM110="
/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc1               auto    auto    defaults    voldmanaged=sdcard1:auto
/devices/platform/omap/musb-omap2430/musb-hdrc/usb1             auto    auto    defaults    voldmanaged=usbdisk0:auto"


DATAPOINT="/data      "

/sbin/busybox echo -e "# Generated on $(/sbin/busybox date) by /sbin/fstab.sh script\n" > $FSTAB

if /sbin/busybox echo "$1" | /sbin/busybox grep -q "1"; then
  CACHEDEV=$HIDDENDEV
  DATAPOINT="/.secondrom"
else
  if /sbin/busybox blkid $SYSTEMDEV | /sbin/busybox grep -q "ext4"; then
    /sbin/busybox echo "$SYSTEMDEV    /system        ext4    ro,noatime,nodiratime    wait" >> $FSTAB
  else
    /sbin/busybox echo "$SYSTEMDEV    /system        f2fs    ro,noatime,nodiratime,$F2FSOPB" >> $FSTAB
  fi
fi

/sbin/busybox echo "$EFS" >> $FSTAB

if /sbin/busybox blkid $CACHEDEV | /sbin/busybox grep -q "ext4"; then
  /sbin/busybox echo "$CACHEDEV    /cache         ext4    nodiratime,$EXT4OPT" >> $FSTAB
else
  /sbin/busybox echo "$CACHEDEV    /cache         f2fs    nodiratime,$F2FSOPT" >> $FSTAB
fi

if /sbin/busybox blkid $DATADEV | /sbin/busybox grep -q "ext4"; then
  /sbin/busybox echo "$DATADEV    $DATAPOINT    ext4    $EXT4OPT,encryptable=footer" >> $FSTAB
else
  /sbin/busybox echo "$DATADEV    $DATAPOINT    f2fs    $F2FSOPT,encryptable=footer" >> $FSTAB
fi


if /sbin/busybox echo "$2" | /sbin/busybox grep -q -i "CM110"; then
  /sbin/busybox echo -e "$CM110" >> $FSTAB
fi

if /sbin/busybox echo "$2" | /sbin/busybox grep -q -i "CM102"; then
  /sbin/busybox echo -e "$CM110" >> $FSTAB
fi

/sbin/busybox echo "" >> $FSTAB
