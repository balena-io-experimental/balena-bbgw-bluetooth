FROM resin/beaglebone-green-wifi-debian:jessie

MAINTAINER Gergely Imreh <gergely@resin.io>

WORKDIR /usr/src/app

# Enable systemd
ENV INITSYSTEM on

# Install bluetooth, remove the apt list to reduce the size of the image
RUN apt-get update && apt-get install -yq --no-install-recommends \
     bluetooth bluez \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy Bluetooth start files for systemd
COPY bluetooth/bb-wl18xx-bluetooth.service /lib/systemd/system/
COPY bluetooth/bb-wl18xx-bluetooth /usr/bin/

# Copy all files from root to the WORKDIR
COPY . ./

# Enable Bluetooth on application start
RUN systemctl enable bb-wl18xx-bluetooth.service

CMD ["bash", "start.sh"]
