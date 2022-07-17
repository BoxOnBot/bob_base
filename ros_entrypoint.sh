#! /bin/bash
set -e

source /opt/ros/foxy/local_setup.bash
. /bob_base_ws/install/local_setup.bash
ros2 launch bob_base_bringup  bob_base_bringup.launch.py
exec "$@"