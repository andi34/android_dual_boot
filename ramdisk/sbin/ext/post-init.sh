#!/sbin/busybox sh

mkdir -p /data/.blackhawk
chmod 777 /data/.blackhawk

# PVR kernel module
insmod /lib/modules/pvrsrvkm_sgx540_120.ko

. /res/customconfig/customconfig-helper

ccxmlsum=`md5sum /res/customconfig/customconfig.xml | awk '{print $1}'`
if [ "a${ccxmlsum}" != "a`cat /data/.blackhawk/.ccxmlsum`" ];
then
  rm -f /data/.blackhawk/*.profile
  echo ${ccxmlsum} > /data/.blackhawk/.ccxmlsum
fi
[ ! -f /data/.blackhawk/default.profile ] && cp /res/customconfig/default.profile /data/.blackhawk

read_defaults
read_config

if [ "$logger" == "on" ];then
insmod /lib/modules/logger.ko
fi

# disable debugging on some modules
if [ "$logger" == "off" ];then
  rm -rf /dev/log
  echo 0 > /sys/module/kernel/parameters/initcall_debug
  echo 0 > /sys/module/lowmemorykiller/parameters/debug_level
  echo 0 > /sys/module/earlysuspend/parameters/debug_mask
  echo 0 > /sys/module/alarm/parameters/debug_mask
  echo 0 > /sys/module/alarm_dev/parameters/debug_mask
  echo 0 > /sys/module/binder/parameters/debug_mask
  echo 0 > /sys/module/xt_qtaguid/parameters/debug_mask
fi

if [ "$xbox" == "on" ];then
insmod /system/lib/modules/xpad.ko
insmod /system/lib/modules/joydev.ko
fi

if [ "$usbmodem" == "on" ];then
insmod /system/lib/modules/ppp_async.ko
insmod /system/lib/modules/usb_wwan.ko
insmod /system/lib/modules/option.ko
fi

if [ "$cifs" == "on" ];then
insmod /system/lib/modules/cifs.ko
fi

if [ "$sec_keyboard" == "on" ];then
insmod /system/lib/modules/pl2303.ko
insmod /system/lib/modules/sec_dock_keyboard.ko
fi

# EFS backup
(
/sbin/busybox sh /sbin/ext/efs-backup.sh
) &

# apply STweaks defaults
export CONFIG_BOOTING=1
/res/uci.sh apply
export CONFIG_BOOTING=

if [ -d /sys/devices/system/cpu/cpufreq/interactive ]; then
  chown system.system /sys/devices/system/cpu/cpufreq/interactive/timer_rate
  chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/timer_rate
  chown system.system /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
  chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
  chown system.system /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
  chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
  chown system.system /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
  chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
  chown system.system /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
  chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
  chown system.system /sys/devices/system/cpu/cpufreq/interactive/boost
  chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/boost
  chown system.system /sys/devices/system/cpu/cpufreq/interactive/boostpulse
  chown system.system /sys/devices/system/cpu/cpufreq/interactive/input_boost
  chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/input_boost
  chown system.system /sys/devices/system/cpu/cpufreq/interactive/screen_off_differential
  chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/screen_off_differential

  echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
  echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
  echo 800000 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
  echo 60 /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
  echo 100000 /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
  echo 10 /sys/devices/system/cpu/cpufreq/interactive/screen_off_differential
fi
