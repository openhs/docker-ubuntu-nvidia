# docker-ubuntu-nvidia

Base Ubuntu docker image with nVidia graphics driver.



## Usage

Create images for X-based GUI applications using the following template:

___Dockerfile___:

    FROM openhs/ubuntu-nvidia

    # put instructions for installing desired GUI application here
    # ...
    
    CMD ["/path/to/gui_app"]

Then start the GUI application container like:

    $ docker run --rm -e DISPLAY=$DISPLAY [-e NVIDIA_DRIVER_VERSION=<host_driver_version>] \
      [--device /dev/<gpu_device> [...]] [--device /dev/<sound_device> [...]] -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v $XAUTHORITY:/tmp/.host_Xauthority:ro -dti <gui_app_image_name>
      
For example:

    $ docker run --name gui_app -e DISPLAY=$DISPLAY -e NVIDIA_DRIVER_VERSION=340 --device /dev/nvidiactl \
      --device /dev/nvidia0 --device /dev/snd -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v $XAUTHORITY:/tmp/.host_Xauthority:ro -dti foo/gui_app
      
and run it again like:

    $ docker start gui_app
