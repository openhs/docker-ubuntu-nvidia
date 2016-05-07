# Dockerfile
#
# Project: docker-ubuntu-nvidia
# License: GNU GPLv3
#
# Copyright (C) 2015 - 2016 Robert Cernansky



FROM ubuntu



MAINTAINER openhs
LABEL version = "0.4.0" \
      description = "Base Ubuntu image with nVidia graphics driver."



RUN /bin/echo -e \
      "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse\n \
       deb http://archive.ubuntu.com/ubuntu/ xenial-updates multiverse\n \
       deb http://archive.ubuntu.com/ubuntu/ xenial-security multiverse" >> \
         /etc/apt/sources.list && \
    apt-get update

ARG default_nvidia_version=361
ENV NVIDIA_DRIVER_VERSION=${default_nvidia_version}

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    nvidia-${default_nvidia_version} \
    xauth \
    # nvidia depends on initramfs-tools
    initramfs-tools

RUN useradd --shell /bin/false --create-home appuser

COPY select_nvidia_driver.sh add_user_to_video_group.sh setup_access_to_host_display.sh \
     docker-ubuntu-nvidia_startup.sh /opt/
RUN chmod +x /opt/select_nvidia_driver.sh /opt/add_user_to_video_group.sh /opt/setup_access_to_host_display.sh \
    /opt/docker-ubuntu-nvidia_startup.sh

ENTRYPOINT ["/opt/docker-ubuntu-nvidia_startup.sh"]
