# docker-ubuntu-nvidia

Base Ubuntu docker image with nVidia graphics driver.



## Usage

Create images for X-based GUI applications using the following template:

___Dockerfile___:

    FROM openhs/ubuntu-nvidia

    # put instructions for installing the GUI application here
    # ...
    
    # add a user
    RUN useradd --create-home appuser
    
    COPY container_startup.sh /opt/
    RUN chmod +x /opt/container_startup.sh
    
    ENTRYPOINT ["/opt/container_startup.sh"]

___container_startup.sh___:

    #!/bin/bash
    
    /opt/select_nvidia_driver.sh
    /opt/add_user_to_video_group.sh appuser
    /opt/setup_access_to_host_display.sh appuser
    
    # start the application
    # su - --shell /bin/sh --command "/path/to/application argument1 .. anrgumentN" appuser

Then start the GUI application container like:

    $ docker run --rm -e DISPLAY=${DISPLAY} -e NVIDIA_DRIVER_VERSION=<host_driver_version> \
      [--device /dev/<gpu_device> [...]] -v /tmp/.X11-unix:/tmp/.X11-unix -v ${XAUTHORITY}:/tmp/.host_Xauthority:ro \
      -dti <gui_app_image_name>
      
For example:

    $ docker run --name gui_app -e DISPLAY=$DISPLAY -e NVIDIA_DRIVER_VERSION=340 --device /dev/nvidiactl \
      --device /dev/nvidia0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $XAUTHORITY:/tmp/.host_Xauthority:ro -dti gui_app
      
and run it again like:

    $ docker start gui_app
