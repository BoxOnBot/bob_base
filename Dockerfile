FROM ros:foxy-ros-base-focal
# Configure environment so we do not get pesky CLI queries
ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timez
# Install relevant dependancies and add ros apt repositories
# RUN apt-get update && apt-get install -y --allow-unauthenticated \
#     apt-utils \
#     locales
# RUN locale-gen en_US en_US.UTF-8
# RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
# RUN export LANG=en_US.UTF-8
# RUN apt-get install -y --allow-unauthenticated \ 
#     software-properties-common \
#     git \
#     python3-pip 
# RUN add-apt-repository universe
# RUN apt-get update && apt-get install -y --allow-unauthenticated \
#     curl \
#     gnupg2 \  
#     lsb-release 
# RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
# RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu focal main" > /etc/apt/sources.list.d/ros2.list
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
    libusb-1.0-0-dev
# Create bob's workspace and source ros
RUN mkdir -p /bob_base_ws/src
RUN cd /bob_base_ws && colcon build
RUN . /bob_base_ws/install/local_setup.sh
# Clone relevant repositories into the workspace and build
RUN git clone -b master https://github.com/BoxOnBot/bob_description.git /bob_base_ws/src/bob_description
RUN git clone -b master https://github.com/BoxOnBot/bob_base_bringup.git /bob_base_ws/src/bob_base_bringup
RUN git clone -b fw-v0.5.3 https://github.com/BoxOnBot/odrive_ros2_control.git /bob_base_ws/src/odrive_ros2_control
RUN cd /bob_base_ws && . /opt/ros/foxy/setup.sh && colcon build --symlink-install
# Copy entrypoint script
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
