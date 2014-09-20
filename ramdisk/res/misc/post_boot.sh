# Kernel tuning template
# Ketut P. Kumajaya, Sept 2013

# CPU voltages
# Default values: 1415 1410 1400 1385 1375 1374 1313 1200 1025 
# Experimental default values: 1415 1410 1375 1360 1325 1274 1213 1100 925 
# echo "1415 1410 1400 1385 1350 1299 1238 1125 950 " > /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table

# CPU frequency
# Available values: 300000, 600000, 800000, 1008000, 1200000, 1350000, 1420000, 1480000, and 1520000
# Default value: 1008000=1.008GHz
# echo 1200000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
# echo 1008000 > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max_freq

# CPU governor
# Available values: hotplug, interactive, conservative, ondemand, userspace, powersave, and performance
# Default value: interactive
# echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# GPU frequency
# Available values: 153600000, 307200000, 384000000, and 512000000
# Default value: 307200000=307.2MHz
# echo 384000000 > /sys/devices/platform/omap/pvrsrvkm.0/sgxfreq/frequency_limit

# GPU governor
# Available values: userspace, on3demand, activeidle, and onoff
# Default value: on3demand
# echo activeidle > /sys/devices/platform/omap/pvrsrvkm.0/sgxfreq/governor

# I/O scheduler
# Available values: noop, deadline, and cfq
# Default value: sio
# echo noop > /sys/block/mmcblk0/queue/scheduler
# echo noop > /sys/block/mmcblk1/queue/scheduler

# TCP congestion control
# Default value: cubic
# sysctl -w net.ipv4.tcp_congestion_control=westwood
