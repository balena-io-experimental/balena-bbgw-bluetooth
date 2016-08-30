#!/bin/bash

echo "Set up Bluetooth"

firmware_location=/lib/firmware/ti-connectivity
mount_point=/mnt/root

if [[ ! -e $mount_point ]]; then
    mkdir $mount_point
    mount --bind $firmware_location $mount_point$firmware_location
elif [[ ! -d $mount_point ]]; then
    echo "$mount_point already exists but is not a directory" 1>&2
fi

cp $mount_point$firmware_location'/*' $firmware_location
# Seem to have to run in twice, as the first run times out at the moment
bb-wl18xx-bluetooth
bb-wl18xx-bluetooth

echo "Bluetooth interfaces"
hcitool dev
while : ; do
  echo "Scan for Bluetooth devices"
  hcitool scan
  sleep 15
  echo "Scan for Bluetooth LE devices"
  hcitool scanle
  sleep 15  
done
