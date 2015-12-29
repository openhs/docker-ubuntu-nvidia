#!/bin/bash

# add_user_to_video_group.sh
#
# Adds a user to a group of nVidia video device.
#
# Project: docker-ubuntu-nvidia
# License: GNU GPLv3
#
# Copyright (C) 2015 Robert Cernansky



VIDEO_DEVICE=/dev/nvidia0



if [ "-h" == "$1" ] || [ "--help" == "$1" ] || [ -z $1 ] || [ "" == "$1" ]; then
    cat <<EOF
Usage:
  ${0} <user>
EOF
  exit 0
fi



if [ ! -e ${VIDEO_DEVICE} ]; then
    cat <<EOF
Error: Video device not found. Create container with options:
  --device /dev/nvidiactl --device /dev/nvidia0"
EOF
    exit 1
fi

user=${1}

videoGroupId=$(stat -c %g ${VIDEO_DEVICE})
if ! grep -q :${videoGroupId}: /etc/group; then
    groupadd --gid ${videoGroupId} video_host
fi
videoGroup=$(stat -c %G ${VIDEO_DEVICE})
if ! id -G ${user} | grep -qw ${videoGroupId}; then
    usermod -a -G ${videoGroupId} ${user}
fi
