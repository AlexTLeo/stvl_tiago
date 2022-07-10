**Authors:** Samuele Depalo, Alex Thanaphon Leonardi, Alice Rivi

# Analysis of the Spatio-Temporal Voxel Layer (STVL)
-------------------------------------------------------------------------------
## Introduction
In this analysis, the performance of the [Spatio-Temporal Voxel Layer](https://github.com/SteveMacenski/spatio_temporal_voxel_layer/tree/galactic) was tested, using a simulated turtlebot3 robot equipped with an RGBD camera, according to some benchmarks:
- CPU consumption given different voxel sizes
- RAM usage given different voxel decay times
- Other qualitative observations

Additionally, lab experiments will be conducted on the **TIAGo** robot from **PAL Robotics** to confirm our simulations.

## Procedure
### 1. Installation
Firstly, we installed the [Galactic Geochelone](https://docs.ros.org/en/galactic/index.html) distribution of **ROS2**.

On top of that, we installed the ROS2 [Navigation 2 Framework v2.1.0.0](https://navigation.ros.org/) and the [STVL](https://github.com/SteveMacenski/spatio_temporal_voxel_layer/tree/galactic) plugin through **apt**.

More specifically, we used the **nav2_bringup** simulation, and we added the STVL layers as plugins to the **nav2_params.yaml**.

The simulation was run on [Gazebo](https://gazebosim.org/home) and monitored on [RViz2](https://index.ros.org/p/rviz2/).

### 2. Environment Building
To test the STVL plugin, we needed test environments through which to run the simulated robot. For this purpose, Gazebo was used to build the environments and SLAM was used to map them.

#### Mapping with SLAM


### 3. Sensor Development

### 4. Testing & Configuration
Our costmap inflation layer was configured to use a radius of 0.40. The RGBD camera equipped on turtlebot3 was configured to have a horizontal FOV of 180°.

STVL can be configured to use different voxel sizes, meaning different levels of resolution in representing 3D environments. 

For our **first test**, the **difference in CPU consumption** given **three different voxel sizes (0.01m, 0.05m, 0.1m)** was measured.

| Voxel Size | CPU consumption |
| ---------- | --------------- |
| 0.01       | 41.2            |

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
