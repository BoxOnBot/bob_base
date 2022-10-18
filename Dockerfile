FROM ros:foxy-ros-base-focal
# Configure environment so we do not get pesky CLI queries
ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timez
# Apt update and upgrade things
RUN apt-get update
RUN apt-get -y upgrade
# Install package dependancies
RUN apt-get install -y --allow-unauthenticated \
    apt-utils \
    software-properties-common \
    git \
    python3-pip \
    ros-foxy-angles \
    ros-foxy-xacro \ 
    ros-foxy-ros2-control \
    ros-foxy-ros2-controllers \
    python3-colcon-common-extensions \
    ros-foxy-rviz2 \
    ros-foxy-transmission-interface \
    libusb-1.0-0-dev \
    ros-foxy-realsense2-camera \
    ros-foxy-usb-cam
# Create bob's workspace and source ros
RUN mkdir -p /bob_base_ws/src
RUN cd /bob_base_ws && colcon build
RUN . /bob_base_ws/install/local_setup.sh
# Clone relevant repositories into the workspace and build
RUN git clone -b master https://github.com/BoxOnBot/bob_base_bringup.git /bob_base_ws/src/bob_base_bringup
RUN git clone -b fw-v0.5.3 https://github.com/BoxOnBot/odrive_ros2_control.git /bob_base_ws/src/odrive_ros2_control
RUN git clone -b master https://github.com/BoxOnBot/bob_description.git /bob_base_ws/src/bob_description
RUN cd /bob_base_ws && . /opt/ros/foxy/setup.sh && colcon build --symlink-install
# Copy entrypoint script
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh

# ENTRYPOINT ["/ros_entrypoint.sh"]
