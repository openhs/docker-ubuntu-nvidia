#!/bin/bash

# docker-ubuntu-nvidia_startup.sh
#
# Startup script for the container.
#
# Project: docker-ubuntu-nvidia
# License: GNU GPLv3
#
# Copyright (C) 2015 - 2016 Robert Cernansky



USER=appuser



if [ "-h" == "${1}" ] || [ "--help" == "${1}" ]; then
    cat <<EOF
Usage:
  docker -e DISPLAY=\${DISPLAY} [-e NVIDIA_DRIVER_VERSION=<host_driver_version>] [--device /dev/<gpu_device> [...]] [--device /dev/<sound_device> [...]] -v /tmp/.X11-unix:/tmp/.X11-unix -v \${XAUTHORITY}:${HOST_XAUTHORITY}:ro openhs/ubuntu-nvidia [app]

  Devices for nVidia GPU with proprietary driver:
    /dev/nvidiactl, /dev/nvidia0

  Devices for an Alsa sound card:
    /dev/snd
  or
    /dev/snd/controlC0, /dev/snd/pcmC0D0p
EOF
  exit 0
fi

echo "ensuring nVidia driver is installed"
/opt/select_nvidia_driver.sh

echo "ensuring that the user is in the video group"
/opt/add_user_to_video_group.sh ${USER}

/opt/docker-ubuntu-x_startup.sh ${@}
