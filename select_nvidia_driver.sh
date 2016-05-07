#!/bin/bash

# select_nvidia_driver.sh
#
# Installs nVidia graphics driver if not already installed.
#
# Project: docker-ubuntu-nvidia
# License: GNU GPLv3
#
# Copyright (C) 2015 Robert Cernansky



if [ "-h" == "$1" ] || [ "--help" == "$1" ]; then
    cat <<EOF
Usage:
  NVIDIA_DRIVER_VERSION=<version> ${0}
EOF
  exit 0
fi



driver=nvidia-${NVIDIA_DRIVER_VERSION}
if ! dpkg-query --status ${driver} > /dev/null 2>&1; then
    echo "Installing ${driver}."
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ${driver}
fi
