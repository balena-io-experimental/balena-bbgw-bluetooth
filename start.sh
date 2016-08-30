#!/bin/bash

echo "Set up Bluetooth"

mkdir -p /mnt/root
mount --bind / /mnt/root

cp /mnt/root/lib/firmware/ti-connectivity/* /lib/firmware/ti-connectivity/


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
