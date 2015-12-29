# Dockerfile
#
# Project: docker-ubuntu-nvidia
# License: GNU GPLv3
#
# Copyright (C) 2015 Robert Cernansky



FROM ubuntu



MAINTAINER openhs
LABEL version = "0.2.0" \
      description = "Base Ubuntu image with nVidia graphics driver."



RUN /bin/echo -e \
      "deb http://archive.ubuntu.com/ubuntu/ trusty multiverse\n \
       deb http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse\n \
       deb http://archive.ubuntu.com/ubuntu/ trusty-security multiverse" >> \
         /etc/apt/sources.list && \
    apt-get update

ARG default_nvidia_version=352

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    nvidia-${default_nvidia_version} \
    xauth

COPY select_nvidia_driver.sh /opt/
RUN chmod +x /opt/select_nvidia_driver.sh
COPY add_user_to_video_group.sh /opt/
RUN chmod +x /opt/add_user_to_video_group.sh
COPY setup_access_to_host_display.sh /opt/
RUN chmod +x /opt/setup_access_to_host_display.sh