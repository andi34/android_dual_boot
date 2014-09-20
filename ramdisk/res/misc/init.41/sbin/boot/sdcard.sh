# SD card swapper script
# Ketut P. Kumajaya, June 2013

# ------------- External SD - Internal Media Swapper ------------- #

if busybox [ $(busybox mount | busybox grep -c sdcard0) -eq 0 ]; then # init.espresso.rc fail to mount /storage/.sdcard
  busybox mount -o bind /storage/.sdcard /storage/sdcard0
fi

# Disable swapper for 2nd ROM
if busybox [ $(busybox mount | grep /system | grep -c /dev/block/loop) -eq 1 ]; then
  exit
fi

# Check if external SD card already inserted
if busybox [ -e /dev/block/mmcblk1p1 ] && [ "$(getprop persist.customboot.sdcard)" = "external" ]; then
  # Loop until extSdCard mounted, better than unpredictible sleep :)
  # but do not loop forever if the system fail to mount SD card
  counter=0
  while busybox [ $(busybox mount | busybox grep -c extSdCard) -eq 0 ] && [ $counter -lt 30 ]; do
    sleep 1
    let counter=counter+1
  done

  if busybox [ $counter -eq 30 ]; then # system fail to mount extSdCard
    exit # quit, do nothing
  fi

  # Umount /storage/extSdCard, mounted by vold
  busybox umount -f /storage/extSdCard
  # Umount /storage/sdcard0
  busybox umount -f /storage/sdcard0
  # Mount internal SD card as external SD card
  busybox mount -o bind /storage/.sdcard /storage/extSdCard
  # Mount external SD card as internal SD card, auto detect fs type seems slower
  busybox mount -t vfat -o dirsync,nosuid,nodev,noexec,noatime,nodiratime,uid=1023,gid=1023,fmask=0002,dmask=0002,allow_utime=0020 /dev/block/mmcblk1p1 /storage/sdcard0

  if busybox [ $(busybox mount | busybox grep -c sdcard0) -eq 0 ]; then # system fail to mount vfat fs
    # untested exfat support -> already tested and works!
    busybox mount -t exfat -o dirsync,nosuid,nodev,noexec,noatime,nodiratime,uid=1023,gid=1023,fmask=0002,dmask=0002,allow_utime=0020 /dev/block/mmcblk1p1 /storage/sdcard0
  fi

  if busybox [ $(busybox mount | busybox grep -c sdcard0) -eq 0 ]; then # system fail to mount exfat fs
    busybox umount -f /storage/extSdCard
    busybox mount -o bind /storage/.sdcard /storage/sdcard0 # default
  fi
fi
