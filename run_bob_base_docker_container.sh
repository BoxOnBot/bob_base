#! /bin/bash

xhost +

docker run -it --rm \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --privileged \
    --volume="/dev/bus/usb:/dev/bus/usb" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    bob_base