# magic busybox

# mount system r/w
/sbin/busybox mount -o remount,rw /system;

# ensure /system/xbin exists
/sbin/busybox mkdir -p /system/xbin
/sbin/busybox chmod 755 /system/xbin

# if symlinked busybox in /system/bin or /system/xbin, remove them
LINK=$(/sbin/busybox find /system/bin/busybox -type l);
if /sbin/busybox [ $LINK = "/system/bin/busybox" ]; then
  /sbin/busybox rm -rf /system/bin/busybox;
fi;
LINK=$(/sbin/busybox find /system/xbin/busybox -type l);
if /sbin/busybox [ $LINK = "/system/xbin/busybox" ]; then
  /sbin/busybox rm -rf /system/xbin/busybox;
fi;

# if real busybox in /system/bin or /system/xbin, rename it
if /sbin/busybox [ -f /system/bin/busybox ]; then
  /sbin/busybox mv /system/bin/busybox /system/bin/busybox.backup
fi;
if /sbin/busybox [ -f /system/xbin/busybox ]; then
  /sbin/busybox mv /system/xbin/busybox /system/xbin/busybox.backup
fi;

# Remove all busybox symlinks
LINK=$(/sbin/busybox ls -l /system/xbin | /sbin/busybox grep busybox | /sbin/busybox awk '{print $9}')
for f in $LINK; do
  if /sbin/busybox [ -h "/system/xbin/$f" ]; then
    /sbin/busybox rm -f "/system/xbin/$f"
  fi
done

# make busybox symlink in /system/xbin
/sbin/busybox ln -s /sbin/busybox /system/xbin/busybox

# install busybox in /system/xbin
/sbin/busybox ln -s busybox /system/xbin/[
/sbin/busybox ln -s busybox /system/xbin/[[
/sbin/busybox ln -s busybox /system/xbin/ash
/sbin/busybox ln -s busybox /system/xbin/awk
/sbin/busybox ln -s busybox /system/xbin/base64
/sbin/busybox ln -s busybox /system/xbin/basename
/sbin/busybox ln -s busybox /system/xbin/bbconfig
/sbin/busybox ln -s busybox /system/xbin/blkid
/sbin/busybox ln -s busybox /system/xbin/blockdev
/sbin/busybox ln -s busybox /system/xbin/bunzip2
/sbin/busybox ln -s busybox /system/xbin/bzcat
/sbin/busybox ln -s busybox /system/xbin/bzip2
/sbin/busybox ln -s busybox /system/xbin/cal
/sbin/busybox ln -s busybox /system/xbin/cat
/sbin/busybox ln -s busybox /system/xbin/catv
/sbin/busybox ln -s busybox /system/xbin/chattr
/sbin/busybox ln -s busybox /system/xbin/chgrp
/sbin/busybox ln -s busybox /system/xbin/chmod
/sbin/busybox ln -s busybox /system/xbin/chown
/sbin/busybox ln -s busybox /system/xbin/chroot
/sbin/busybox ln -s busybox /system/xbin/clear
/sbin/busybox ln -s busybox /system/xbin/cmp
/sbin/busybox ln -s busybox /system/xbin/cp
/sbin/busybox ln -s busybox /system/xbin/cpio
/sbin/busybox ln -s busybox /system/xbin/cut
/sbin/busybox ln -s busybox /system/xbin/date
/sbin/busybox ln -s busybox /system/xbin/dc
/sbin/busybox ln -s busybox /system/xbin/dd
/sbin/busybox ln -s busybox /system/xbin/depmod
/sbin/busybox ln -s busybox /system/xbin/devmem
/sbin/busybox ln -s busybox /system/xbin/df
/sbin/busybox ln -s busybox /system/xbin/diff
/sbin/busybox ln -s busybox /system/xbin/dirname
/sbin/busybox ln -s busybox /system/xbin/dmesg
/sbin/busybox ln -s busybox /system/xbin/dos2unix
/sbin/busybox ln -s busybox /system/xbin/du
/sbin/busybox ln -s busybox /system/xbin/echo
/sbin/busybox ln -s busybox /system/xbin/egrep
/sbin/busybox ln -s busybox /system/xbin/env
/sbin/busybox ln -s busybox /system/xbin/expand
/sbin/busybox ln -s busybox /system/xbin/expr
/sbin/busybox ln -s busybox /system/xbin/false
/sbin/busybox ln -s busybox /system/xbin/fdisk
/sbin/busybox ln -s busybox /system/xbin/fgrep
/sbin/busybox ln -s busybox /system/xbin/find
/sbin/busybox ln -s busybox /system/xbin/fold
/sbin/busybox ln -s busybox /system/xbin/free
/sbin/busybox ln -s busybox /system/xbin/freeramdisk
/sbin/busybox ln -s busybox /system/xbin/fuser
/sbin/busybox ln -s busybox /system/xbin/getopt
/sbin/busybox ln -s busybox /system/xbin/grep
/sbin/busybox ln -s busybox /system/xbin/groups
/sbin/busybox ln -s busybox /system/xbin/gunzip
/sbin/busybox ln -s busybox /system/xbin/gzip
/sbin/busybox ln -s busybox /system/xbin/head
/sbin/busybox ln -s busybox /system/xbin/hexdump
/sbin/busybox ln -s busybox /system/xbin/id
/sbin/busybox ln -s busybox /system/xbin/insmod
/sbin/busybox ln -s busybox /system/xbin/install
/sbin/busybox ln -s busybox /system/xbin/kill
/sbin/busybox ln -s busybox /system/xbin/killall
/sbin/busybox ln -s busybox /system/xbin/killall5
/sbin/busybox ln -s busybox /system/xbin/less
/sbin/busybox ln -s busybox /system/xbin/ln
/sbin/busybox ln -s busybox /system/xbin/losetup
/sbin/busybox ln -s busybox /system/xbin/ls
/sbin/busybox ln -s busybox /system/xbin/lsattr
/sbin/busybox ln -s busybox /system/xbin/lsmod
/sbin/busybox ln -s busybox /system/xbin/lsof
# /sbin/busybox ln -s busybox /system/xbin/lspci
/sbin/busybox ln -s busybox /system/xbin/lsusb
/sbin/busybox ln -s busybox /system/xbin/lzcat
/sbin/busybox ln -s busybox /system/xbin/lzop
/sbin/busybox ln -s busybox /system/xbin/lzopcat
/sbin/busybox ln -s busybox /system/xbin/makedevs
/sbin/busybox ln -s busybox /system/xbin/md5sum
/sbin/busybox ln -s busybox /system/xbin/mkdir
/sbin/busybox ln -s busybox /system/xbin/mkdosfs
/sbin/busybox ln -s busybox /system/xbin/mke2fs
/sbin/busybox ln -s busybox /system/xbin/mkfifo
/sbin/busybox ln -s busybox /system/xbin/mkfs.ext2
/sbin/busybox ln -s busybox /system/xbin/mkfs.vfat
/sbin/busybox ln -s busybox /system/xbin/mknod
/sbin/busybox ln -s busybox /system/xbin/mkswap
/sbin/busybox ln -s busybox /system/xbin/mktemp
/sbin/busybox ln -s busybox /system/xbin/modinfo
/sbin/busybox ln -s busybox /system/xbin/modprobe
/sbin/busybox ln -s busybox /system/xbin/more
/sbin/busybox ln -s busybox /system/xbin/mount
/sbin/busybox ln -s busybox /system/xbin/mountpoint
/sbin/busybox ln -s busybox /system/xbin/mv
/sbin/busybox ln -s busybox /system/xbin/nanddump
/sbin/busybox ln -s busybox /system/xbin/nandwrite
/sbin/busybox ln -s busybox /system/xbin/nice
/sbin/busybox ln -s busybox /system/xbin/nohup
/sbin/busybox ln -s busybox /system/xbin/od
/sbin/busybox ln -s busybox /system/xbin/patch
/sbin/busybox ln -s busybox /system/xbin/pgrep
/sbin/busybox ln -s busybox /system/xbin/pidof
/sbin/busybox ln -s busybox /system/xbin/pkill
/sbin/busybox ln -s busybox /system/xbin/printenv
/sbin/busybox ln -s busybox /system/xbin/printf
/sbin/busybox ln -s busybox /system/xbin/ps
/sbin/busybox ln -s busybox /system/xbin/pstree
/sbin/busybox ln -s busybox /system/xbin/pwd
/sbin/busybox ln -s busybox /system/xbin/rdev
/sbin/busybox ln -s busybox /system/xbin/readlink
/sbin/busybox ln -s busybox /system/xbin/realpath
/sbin/busybox ln -s busybox /system/xbin/renice
/sbin/busybox ln -s busybox /system/xbin/reset
/sbin/busybox ln -s busybox /system/xbin/resize
/sbin/busybox ln -s busybox /system/xbin/rev
/sbin/busybox ln -s busybox /system/xbin/rm
/sbin/busybox ln -s busybox /system/xbin/rmdir
/sbin/busybox ln -s busybox /system/xbin/rmmod
/sbin/busybox ln -s busybox /system/xbin/run-parts
/sbin/busybox ln -s busybox /system/xbin/sed
/sbin/busybox ln -s busybox /system/xbin/seq
/sbin/busybox ln -s busybox /system/xbin/setconsole
/sbin/busybox ln -s busybox /system/xbin/setserial
/sbin/busybox ln -s busybox /system/xbin/setsid
/sbin/busybox ln -s busybox /system/xbin/sh
/sbin/busybox ln -s busybox /system/xbin/sha1sum
/sbin/busybox ln -s busybox /system/xbin/sha256sum
/sbin/busybox ln -s busybox /system/xbin/sha512sum
/sbin/busybox ln -s busybox /system/xbin/sleep
/sbin/busybox ln -s busybox /system/xbin/sort
/sbin/busybox ln -s busybox /system/xbin/split
/sbin/busybox ln -s busybox /system/xbin/stat
/sbin/busybox ln -s busybox /system/xbin/strings
/sbin/busybox ln -s busybox /system/xbin/stty
/sbin/busybox ln -s busybox /system/xbin/swapoff
/sbin/busybox ln -s busybox /system/xbin/swapon
/sbin/busybox ln -s busybox /system/xbin/sync
/sbin/busybox ln -s busybox /system/xbin/sysctl
/sbin/busybox ln -s busybox /system/xbin/tac
/sbin/busybox ln -s busybox /system/xbin/tail
/sbin/busybox ln -s busybox /system/xbin/tar
/sbin/busybox ln -s busybox /system/xbin/tee
/sbin/busybox ln -s busybox /system/xbin/test
/sbin/busybox ln -s busybox /system/xbin/time
/sbin/busybox ln -s busybox /system/xbin/top
/sbin/busybox ln -s busybox /system/xbin/touch
/sbin/busybox ln -s busybox /system/xbin/tr
/sbin/busybox ln -s busybox /system/xbin/true
/sbin/busybox ln -s busybox /system/xbin/ttysize
/sbin/busybox ln -s busybox /system/xbin/tune2fs
/sbin/busybox ln -s busybox /system/xbin/umount
/sbin/busybox ln -s busybox /system/xbin/uname
/sbin/busybox ln -s busybox /system/xbin/unexpand
/sbin/busybox ln -s busybox /system/xbin/uniq
/sbin/busybox ln -s busybox /system/xbin/unix2dos
/sbin/busybox ln -s busybox /system/xbin/unlzma
/sbin/busybox ln -s busybox /system/xbin/unlzop
/sbin/busybox ln -s busybox /system/xbin/unxz
/sbin/busybox ln -s busybox /system/xbin/unzip
/sbin/busybox ln -s busybox /system/xbin/uptime
/sbin/busybox ln -s busybox /system/xbin/usleep
/sbin/busybox ln -s busybox /system/xbin/uudecode
/sbin/busybox ln -s busybox /system/xbin/uuencode
/sbin/busybox ln -s busybox /system/xbin/watch
/sbin/busybox ln -s busybox /system/xbin/wc
/sbin/busybox ln -s busybox /system/xbin/which
/sbin/busybox ln -s busybox /system/xbin/whoami
/sbin/busybox ln -s busybox /system/xbin/xargs
/sbin/busybox ln -s busybox /system/xbin/xzcat
/sbin/busybox ln -s busybox /system/xbin/yes
/sbin/busybox ln -s busybox /system/xbin/zcat

/sbin/busybox ln -s busybox /system/xbin/adjtimex
/sbin/busybox ln -s busybox /system/xbin/arp
/sbin/busybox ln -s busybox /system/xbin/brctl
/sbin/busybox ln -s busybox /system/xbin/comm
/sbin/busybox ln -s busybox /system/xbin/crond
/sbin/busybox ln -s busybox /system/xbin/crontab
/sbin/busybox ln -s busybox /system/xbin/dnsd
/sbin/busybox ln -s busybox /system/xbin/ed
# /sbin/busybox ln -s busybox /system/xbin/fbsplash
/sbin/busybox ln -s busybox /system/xbin/flash_lock
/sbin/busybox ln -s busybox /system/xbin/flash_unlock
/sbin/busybox ln -s busybox /system/xbin/flashcp
/sbin/busybox ln -s busybox /system/xbin/flock
/sbin/busybox ln -s busybox /system/xbin/fstrim
/sbin/busybox ln -s busybox /system/xbin/fsync
/sbin/busybox ln -s busybox /system/xbin/ftpget
/sbin/busybox ln -s busybox /system/xbin/ftpput
/sbin/busybox ln -s busybox /system/xbin/halt
/sbin/busybox ln -s busybox /system/xbin/ifconfig
/sbin/busybox ln -s busybox /system/xbin/inetd
# /sbin/busybox ln -s busybox /system/xbin/ionice
/sbin/busybox ln -s busybox /system/xbin/iostat
/sbin/busybox ln -s busybox /system/xbin/ip
/sbin/busybox ln -s busybox /system/xbin/lzma
/sbin/busybox ln -s busybox /system/xbin/man
/sbin/busybox ln -s busybox /system/xbin/mesg
/sbin/busybox ln -s busybox /system/xbin/mpstat
# /sbin/busybox ln -s busybox /system/xbin/nbd-client
# /sbin/busybox ln -s busybox /system/xbin/nc
/sbin/busybox ln -s busybox /system/xbin/netstat
/sbin/busybox ln -s busybox /system/xbin/nslookup
/sbin/busybox ln -s busybox /system/xbin/ntpd
/sbin/busybox ln -s busybox /system/xbin/ping
# /sbin/busybox ln -s busybox /system/xbin/pipe_progress
/sbin/busybox ln -s busybox /system/xbin/pmap
/sbin/busybox ln -s busybox /system/xbin/poweroff
/sbin/busybox ln -s busybox /system/xbin/pwdx
# /sbin/busybox ln -s busybox /system/xbin/reboot
/sbin/busybox ln -s busybox /system/xbin/route
/sbin/busybox ln -s busybox /system/xbin/rx
/sbin/busybox ln -s busybox /system/xbin/sum
/sbin/busybox ln -s busybox /system/xbin/taskset
/sbin/busybox ln -s busybox /system/xbin/telnet
/sbin/busybox ln -s busybox /system/xbin/telnetd
/sbin/busybox ln -s busybox /system/xbin/tftp
/sbin/busybox ln -s busybox /system/xbin/tftpd
/sbin/busybox ln -s busybox /system/xbin/timeout
/sbin/busybox ln -s busybox /system/xbin/traceroute
/sbin/busybox ln -s busybox /system/xbin/uncompress
/sbin/busybox ln -s busybox /system/xbin/vi
/sbin/busybox ln -s busybox /system/xbin/wget
/sbin/busybox ln -s busybox /system/xbin/xz

# mount system r/o
/sbin/busybox sync
/sbin/busybox mount -o remount,ro /system;
