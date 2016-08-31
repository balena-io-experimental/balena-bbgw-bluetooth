FROM resin/beaglebone-green-wifi-debian:jessie

MAINTAINER Gergely Imreh <gergely@resin.io>

WORKDIR /usr/src/app

ENV INITSYSTEM on

COPY bbgw.list /etc/apt/sources.list.d/

# Install openSSH, remove the apt list to reduce the size of the image
RUN apt-get update && apt-get install -yq --no-install-recommends \
     bluetooth bluez bb-wl18xx-firmware \
     patch \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy all files from root to the WORKDIR
COPY . ./

# Patch the bluetooth startup script to start more reliably
# Ignore if cannot patch (possibly because of upstream fix in the future
RUN patch /usr/bin/bb-wl18xx-bluetooth < bluetooth-start-return.patch || true
RUN patch /lib/systemd/system/bb-wl18xx-bluetooth.service < bluetooth-service.patch || true

## No need to run this manually, the firmware automatically enables the service!
# RUN systemctl enable bb-wl18xx-bluetooth.service
## If do not want to automatically load the bluetooth service, use this below
# RUN systemctl disable bb-wl18xx-bluetooth.service

# Disable wifi service from the firware, which might interfere with the resin setup
RUN systemctl disable bb-wl18xx-wlan0.service

CMD ["bash", "start.sh"]
