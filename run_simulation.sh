#!/bin/bash

# Make sure that the .yaml and .pgm files are in the nav2_bringup/maps and
# nav2_bringup/worlds directories
# example: ./run_simulation.sh world.yaml world.model true
# param1: .yaml file of the mapped environment
# param2: .model file of the world
# param3: true to RUN simulaton, false to build only

# Modify launch file map and world names
awk '{gsub(/map+\_+[a-z+0-9]+\.+yaml/, "'$1'")}1' navigation2/nav2_bringup/bringup/launch/tb3_simulation_launch.py > tb3_simulation_launch_new.py
mv tb3_simulation_launch_new.py tb3_simulation_launch.py
awk '{gsub(/world+\_+[a-z+0-9]+\.+model/, "'$2'")}1' navigation2/nav2_bringup/bringup/launch/tb3_simulation_launch.py > tb3_simulation_launch_new.py
mv tb3_simulation_launch_new.py tb3_simulation_launch.py

# Build the simulation
cd ..
colcon build --packages-select nav2_bringup --allow-overriding nav2_bringup
colcon build --packages-select-by-dep nav2_bringup

# Source ROS2
source ./install/setup.bash

# Run it!
if ($3 == true) then
  ros2 launch nav2_bringup tb3_simulation_launch.py
fi
