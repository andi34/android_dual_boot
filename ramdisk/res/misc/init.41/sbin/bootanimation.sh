#!/system/bin/sh

mount -o remount,rw /system

if [ -f /data/local/bootanimation.zip ] || [ -f /system/media/bootanimation.zip ]; then
  if [ -f /system/media/video/shutdown/shutdown.qmg ]; then
    mv /system/media/video/shutdown/shutdown.qmg /system/media/video/shutdown/shutdown.qmg.bak
  fi;
  if [ -f /system/media/audio/ui/PowerOn.ogg ]; then
    mv /system/media/audio/ui/PowerOn.ogg /system/media/audio/ui/PowerOn.ogg.bak
  fi;
  /system/bin/bootanimation
else
  if [ -f /system/media/video/shutdown/shutdown.qmg.bak ]; then
    mv /system/media/video/shutdown/shutdown.qmg.bak /system/media/video/shutdown/shutdown.qmg
  fi;
  if [ -f /system/media/audio/ui/PowerOn.ogg.bak ]; then
    mv /system/media/audio/ui/PowerOn.ogg.bak /system/media/audio/ui/PowerOn.ogg
  fi;
  /system/bin/samsungani
fi;

mount -o remount,ro /system
