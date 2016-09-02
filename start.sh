#!/bin/bash

# Copying firmware
if [ ! -f "/lib/firmware/ti-connectivity/TIInit_11.8.32.bts" ]; then
 echo "Firware is not present, copying"
 cp firmware/TIInit_11.8.32.bts /lib/firmware/ti-connectivity/
 cp firmware/wl18xx-conf.bin /lib/firmware/ti-connectivity/
 ln -s ti-connectivity/TIInit_11.8.32.bts /lib/firmware/TIInit_11.8.32.bts
fi

echo "Finding Bluetooth interface"
while [ -z "$(hcitool dev |grep hci0)" ]; do echo "...nothing yet"; sleep 2; done

if [ -n "$DEBUG" ]; then
  systemctl status bb-wl18xx-bluetooth.service -l
fi

echo "Bluetooth interfaces"
hcitool dev
while : ; do
  echo "Scan for Bluetooth devices"
  hcitool -i hci0 scan
  sleep 5
  echo "Scan for Bluetooth Low Energy devices"
  timeout -s SIGINT 10s hcitool -i hci0 lescan
  sleep 5
done
