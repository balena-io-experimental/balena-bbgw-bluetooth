#!/bin/bash

echo "Set up Bluetooth"
# Seem to have to run in twice, as the first run times out at the moment
bb-wl18xx-bluetooth
bb-wl18xx-bluetooth

echo "Bluetooth interfaces"
hcitool dev
while : ; do
  echo "Scan for Bluetooth devices"
  hcitool scan
  sleep 15
done
