#!/sbin/busybox sh

# Ketut P. Kumajaya, Sept 2013, Mar 2014
# Do not remove above credits header!

REBOOT_NORMAL=$(/sbin/busybox grep -c androidboot.mode=reboot_normal /proc/cmdline)
POWER_KEY=$(/sbin/busybox grep -c androidboot.mode=power_key /proc/cmdline)

if /sbin/busybox [ "$REBOOT_NORMAL" == 1 ] || /sbin/busybox [ "$POWER_KEY" == 1 ]; then
  # /sbin/busybox echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
  /sbin/busybox echo 0 > /sys/devices/virtual/sec/tsp/pivot
  /sbin/busybox timeout -t 5 -s CONT /sbin/busybox sh -c "/sbin/aroma 1 0 /res/misc/bootmenu.zip"
  /sbin/busybox dd if=/dev/zero of=/dev/graphics/fb0
  /sbin/busybox echo 1 > /sys/devices/virtual/sec/tsp/pivot
  # /sbin/busybox echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
fi
