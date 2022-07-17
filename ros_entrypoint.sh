#! /bin/bash
set -e

source /opt/ros/foxy/local_setup.bash
. /bob_ws/install/local_setup.bash
ros2 launch bob_bringup  bob_bringup.launch.py
exec "$@"