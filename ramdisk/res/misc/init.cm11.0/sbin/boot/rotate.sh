# Galaxy Tab 2 7.0 auto rotation script
# Ketut P. Kumajaya, Sept 2013

# mount /system read-write
busybox mount -o remount,rw /system

# parsing build.prop
if busybox [ $(busybox grep -c ro.sf.hwrotation=270 /system/build.prop) -eq 1 ]; then
  # make sure the touchcreen driver in portrait mode
  echo 1 > /sys/devices/virtual/sec/tsp/pivot
  # link espresso camera HAL
  busybox ln -sf blackhawk/vendor-camera.espresso.so /system/lib/hw/vendor-camera.piranha.so
else
  # make sure the touchcreen driver in landscape mode
  echo 0 > /sys/devices/virtual/sec/tsp/pivot
  # set accelerometer position, landscape mode
  position=$(busybox find /sys/devices/virtual/input/ -type f -name name | busybox xargs busybox grep '^accelerometer$' | busybox sed 's@name:accelerometer@position@')
  echo -n 7 > $position
  position=$(busybox find /sys/devices/platform/omap/omap_i2c.4/i2c-4/4-002e/input/ -type f -name name | busybox xargs busybox grep '^geomagnetic$' | busybox sed 's@name:geomagnetic@position@')
  echo -n 7 > $position
  # link espresso10 camera HAL
  busybox ln -sf blackhawk/vendor-camera.espresso10.so /system/lib/hw/vendor-camera.piranha.so
fi

# mount /system read-only
busybox sync
busybox mount -o remount,ro /system
