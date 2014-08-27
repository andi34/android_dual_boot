#!/sbin/busybox sh

# Ketut P. Kumajaya, Sept 2013, Nov 2013
# Do not remove above credits header!

/sbin/busybox timeout -t 5 -s CONT /sbin/busybox sh -c "/sbin/aroma 1 0 /res/misc/bootmenu.zip"
/sbin/busybox dd if=/dev/zero of=/dev/graphics/fb0
