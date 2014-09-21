# Galaxy Tab 2 7.0 zram manager
# Ketut P. Kumajaya, July 2013
# based on cyanogen compcache handler
# modified for dual core CPU

MEMTOTAL=$(grep MemTotal /proc/meminfo | awk ' { print $2 } ')

if [ `getprop persist.service.zram` == 1 ]; then
  PROP=26
  setprop persist.service.zram $PROP
fi

if [ -e /data/property/persist.service.zram ]; then
  PROP=`getprop persist.service.zram`
else
  PROP=0
  setprop persist.service.zram $PROP
fi

if [ $PROP != 0 ]; then
  CCSIZE=$(($(($MEMTOTAL * $PROP)) / 100))
  /system/bin/compcache start $CCSIZE
else
  /system/bin/compcache stop
fi

exit 0
