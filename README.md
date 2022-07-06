**Authors:** Samuele Depalo, Alex Thanaphon Leonardi, Alice Rivi

# Analysis of the Spatio-Temporal Voxel Layer (STVL)
-------------------------------------------------------------------------------
## Introduction
In this analysis, the performance of the [Spatio-Temporal Voxel Layer](https://github.com/SteveMacenski/spatio_temporal_voxel_layer/tree/galactic) was tested according to several relevant benchmarks:
- one
- two
- three
- more

Additionally, lab experiments were conducted on the **TIAGo** robot from **PAL Robotics** to confirm our findings.

## Procedure
### 1. Installation
Firstly, we installed the [Galactic Geochelone](https://docs.ros.org/en/galactic/index.html) distribution of **ROS2**.

On top of that, we installed the ROS2 [Navigation 2 Framework v2.1.0.0](https://navigation.ros.org/), alongside the STVL plugin, which was then added to the simulation parameter .yaml file.

More specifically, we used the **nav2_bringup** simulation, and we added the [STVL](https://github.com/SteveMacenski/spatio_temporal_voxel_layer/tree/galactic) layers as plugins to the **nav2_params.yaml**.

The simulation was run on [Gazebo](https://gazebosim.org/home) and monitored on [RViz2](https://index.ros.org/p/rviz2/).

### 2. Environment Building
#### Mapping with SLAM

### 3. Sensor Development

### 4. Testing & Criteria

## Encountered Issues
A big issue that we encountered was in trying to use a simulated version of TIAGo in our environments (since the experimental tests were conducted on TIAGo). STVL is written for ROS2, but TIAGo runs on ROS1. We looked around quite thoroughly around PAL Robotics' official GitHub, and although they provide numerous simulations and tutorials for ROS1 (understandably), their ROS2 brances are still in development and apparently inaccessible.

A simulation of TIAGo on ROS2 does exist for WeBots, but there were several issues.
<br>
First of all, the RGBD camera is wrongly rotated.
<br>
Secondly, RViz insisted on listening to the wrong camera_info topic, so we had to write a node that republished all camera-related information towards said topic.
<br>
Even after finally correcting all camera-related issues, the STVL layer would not be displayed on RViz, giving no apparent errors. Instead of spending more time on this route, we decided to simply go back to what already worked well: applying STVL to turtlebot3 on Gazebo. This was much more time-effective as it allowed us to focus on the tests themselves.
## Results

## Conclusions

## Future considerations
