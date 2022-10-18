# Bob_base

## Dockerfiles for easy deployment of bob's base functionalities.

This repository contains the relevant dockerfiles and scripts for the deployment of Bob's base functionalities. This readme also doubles as a summary of bob's base functionalities and their development status.

Bob's base functionalities include:

1. Teleoperation of Bob
2. Trajectory following
3. Interfacing with sensors and the publishing of relevant sensor messages including:
    1. Ultrasonic bubble information
    2. IMU information (after correction)
    3. Monocular camera information (after correction)
    4. Stereo camera information (after correction)
    5. Odometry messages (pre-sensor fusion)
    6. Battry status

## Development status

- [x] Teleoperation of bob
- [x] Publishing of Bob's odometry
- [ ] Publishing of Bob's ultrasonic bubble information
- [ ] Publishing of Bob's stereo camera information (raw)
- [ ] Publishing of Bob's monocular camera information (raw)
- [ ] Publishing of Bob's IMU information (raw)
- [ ] Sensor calibration and publishing of corrected sensor information
- [ ] Trajectory following 
- [ ] Publishing of Bob's battery information (and other utils)

## Modules relevant to bob's base functionalities

1. [bob_description](https://github.com/BoxOnBot/bob_description)
2. [odrive_ros2_control](https://github.com/BoxOnBot/odrive_ros2_control)
3. [bob_base_bringup](https://github.com/BoxOnBot/bob_base_bringup)

# Docker and deployment

Running a container with the docker image built by dockerfile provided in this repository launches an entrypoint script that runs `bob_base_bringup.launch.py`, which starts the relevant nodes to enable bob's base functionalities.

## Building and running the docker image

1. Clone this repository
2. Install [docker](https://www.docker.com/get-started/) and setup the relevant [user permissions](https://docs.docker.com/engine/install/linux-postinstall/) to use docker as a non-root user. 
3. Give execution permissions to the dockerfile run and build scripts by navigating to the root directory of the repository and running
```
chmod +x build_bob_base_dockerfile.sh
chmod +x run_bob_base_docker_container.sh
```
4. Build the docker image 
```
./build_bob_base_dockerfile.sh
```
5. Run the docker image
```
./run_bob_base_docker_container.sh
```

## Relevant Subscribed topics

/diffbot_base_controller/cmd_vel_unstamped (`geometry_msgs/msg/Twist`)
    Used for teleoperation of bob

## Relevant Published topics

/odom (`nav_msgs/msg/Odometry`)
    Pre-fused odometry of bob

/tf (`tf2_msgs/msg/TFMessage`)
    TF information of bob


