# From gokhanmoral's siyah kernel initramfs
# simplified and adapted to Galaxy Tab 2 by Ketut P. Kumajaya

# Enable kmem interface for everyone
echo 0 > /proc/sys/kernel/kptr_restrict

# I/O related tweaks optimize non-rotating storage
MMC=`ls -d /sys/block/mmc*`;

for i in $MMC; do
  # IMPORTANT!
  echo 0 > $i/queue/rotational; 
  echo 8192 > $i/queue/nr_requests; # for starters: keep it sane
  # CFQ specific
  if [ -e $i/queue/iosched/back_seek_penalty ]; then 
    echo 1 > $i/queue/iosched/back_seek_penalty;
  fi;
  # CFQ specific
  if [ -e $i/queue/iosched/low_latency ]; then
    echo 1 > $i/queue/iosched/low_latency;
  fi;
  # CFQ Specific
  if [ -e $i/queue/iosched/slice_idle ]; then 
    echo 1 > $i/queue/iosched/slice_idle; # previous: 1
  fi;
  # deadline/VR/SIO scheduler specific
  if [ -e $i/queue/iosched/fifo_batch ]; then
    echo 4 > $i/queue/iosched/fifo_batch;
  fi;
  if [ -e $i/queue/iosched/writes_starved ]; then
    echo 1 > $i/queue/iosched/writes_starved;
  fi;
  # CFQ specific
  if [ -e $i/queue/iosched/quantum ]; then
    echo 8 > $i/queue/iosched/quantum;
  fi;
  # VR Specific
  if [ -e $i/queue/iosched/rev_penalty ]; then
    echo 1 > $i/queue/iosched/rev_penalty;
  fi;
  echo "1" > $i/queue/rq_affinity;   
  # disable iostats to reduce overhead  # idea by kodos96 - thanks !
  echo "0" > $i/queue/iostats;
  # Optimize for read- & write-throughput; 
  # Optimize for readahead; 
  echo "256" > $i/queue/read_ahead_kb;
done;

# Raising read_ahead_kb cache-value for mounts that are sdcard-like to 1024 
echo "1024" > /sys/devices/virtual/bdi/179:0/read_ahead_kb;
echo "1024" > /sys/devices/virtual/bdi/179:8/read_ahead_kb;
echo "1024" > /sys/devices/virtual/bdi/179:16/read_ahead_kb;
echo "1024" > /sys/devices/virtual/bdi/179:24/read_ahead_kb;
echo "256" > /sys/devices/virtual/bdi/default/read_ahead_kb;

# Remount all partitions with noatime
for k in $(busybox mount | grep ext4 | cut -d " " -f3); do
  sync;
  if [ "$k" = "/system" ]; then
    busybox mount -o remount,noatime,nodiratime $k;
  elif [ "$k" = "/data" ]; then
    busybox mount -o remount,noatime,noauto_da_alloc $k;
  else
    busybox mount -o remount,noatime,nodiratime,noauto_da_alloc $k;
  fi;
done

for k in $(busybox mount | grep relatime | cut -d " " -f3); do
  sync;
  busybox mount -o remount,noatime,nodiratime $k;
done

# TCP read/write tweaks
busybox sysctl -w net.ipv4.tcp_timestamps=0; # default: 1
busybox sysctl -w net.ipv4.tcp_tw_reuse=1; # default: 0
busybox sysctl -w net.ipv4.tcp_sack=1; # default: 1
busybox sysctl -w net.ipv4.tcp_dsack=1; # default: 1
busybox sysctl -w net.ipv4.tcp_tw_recycle=1; # default: 0
busybox sysctl -w net.ipv4.tcp_window_scaling=1; # default 1
busybox sysctl -w net.ipv4.tcp_keepalive_probes=5; # defaut: 9
busybox sysctl -w net.ipv4.tcp_keepalive_intvl=30; # defaut: 75
busybox sysctl -w net.ipv4.tcp_fin_timeout=30; # defaut: 60
busybox sysctl -w net.ipv4.tcp_moderate_rcvbuf=1; # default: 1

# Configure the server to ignore broadcast pings and smurf attacks:
# (smurf-attacks)
busybox sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1; # default: 1
if [ -e /proc/sys/net/ipv6/icmp_echo_ignore_broadcasts ]; then # not exists on Galaxy Tab 2
  echo "1" >  /proc/sys/net/ipv6/icmp_echo_ignore_broadcasts;
fi;

# Ignore all kinds of icmp packets or pings:
busybox sysctl -w net.ipv4.icmp_echo_ignore_all=1; # default: 0
if [ -e /proc/sys/net/ipv6/icmp_echo_ignore_all ]; then # not exists on Galaxy Tab 2
  echo "1" >  /proc/sys/net/ipv6/icmp_echo_ignore_all;
fi;

# Some routers send invalid responses to broadcast frames, and each one generates a
# warning that is logged by the kernel. These responses can be ignored:
busybox sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1; # default: 1
if [ -e /proc/sys/net/ipv6/icmp_ignore_bogus_error_responses ]; then # not exists on Galaxy Tab 2
  echo "1" >  /proc/sys/net/ipv6/icmp_ignore_bogus_error_responses;
fi;

# When the server is heavily loaded or has many clients with bad connections with high
# latency, it can result in an increase in half-open connections. This is common for Web
# servers, especially when there are a lot of dial-up users. These half-open connections are
# stored in the backlog connections queue. You should set this value to at least 4096. (The
# default is 1024.)
# Setting this value is useful even if your server does not receive this kind of connection,
# because it can still be protected from a DoS (syn-flood) attack.
busybox sysctl -w net.ipv4.tcp_max_syn_backlog=4096; # default: 512

# Increase the number of outstanding syn requests allowed.
# Note: some people (including myself) have used tcp_syncookies to handle the problem of too many legitimate outstanding SYNs. 
busybox sysctl -w net.core.netdev_max_backlog=2500; # default: 1000

# While TCP SYN cookies are helpful in protecting the server from syn-flood attacks, both
# denial-of-service (DoS) or distributed denial-of-service (DDoS), they could have an
# adverse effect on performance. We suggest enabling TCP SYN cookies only when there is
# a clear need for them.

# disabling syncookies
# busybox sysctl -w net.ipv4.tcp_syncookies=0; # an unknown key

# disable  IP dynaddr
busybox sysctl -w net.ipv4.ip_dynaddr=0; # default: 0

# entropy tweaks
busybox sysctl -w kernel.random.read_wakeup_threshold=512
busybox sysctl -w kernel.random.write_wakeup_threshold=1024
busybox ln -sf /dev/urandom /dev/random
