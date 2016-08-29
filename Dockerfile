FROM resin/beaglebone-green-wifi-debian:jessie

ENV WORKDIR /usr/src/app

ENV INITSYSTEM on

COPY bbgw.list /etc/apt/sources.list.d/

# Install openSSH, remove the apt list to reduce the size of the image
RUN apt-get update && apt-get install -yq --no-install-recommends \
     bluetooth bluez bluetooth bb-wl18xx-firmware \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy all files from root to the WORKDIR
COPY . ./

# Switch on systemd init
ENV INITSYSTEM on

CMD ["bash", "start.sh"]

