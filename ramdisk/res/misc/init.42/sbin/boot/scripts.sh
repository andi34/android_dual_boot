if busybox [ -d /system/etc/init.d ]; then
  busybox run-parts /system/etc/init.d
fi;
