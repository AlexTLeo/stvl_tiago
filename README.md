**Authors:** Samuele Depalo, Alex Thanaphon Leonardi, Alice Rivi

# Analysis of the Spatio-Temporal Voxel Layer (STVL)
-------------------------------------------------------------------------------
## Introduction
In this analysis, the performance of the [Spatio-Temporal Voxel Layer](https://github.com/SteveMacenski/spatio_temporal_voxel_layer/tree/galactic) was tested, using a simulated turtlebot3 robot equipped with an RGBD camera, according to some benchmarks:
- CPU consumption given different voxel sizes
- RAM usage given different voxel sizes
- Other qualitative observations

Additionally, lab experiments will be conducted on the **TIAGo** robot from **PAL Robotics** to confirm our simulations.

## Procedure
### 1. Installation
Firstly, we installed the [Galactic Geochelone](https://docs.ros.org/en/galactic/index.html) distribution of **ROS2**.

On top of that, we installed the ROS2 [Navigation 2 Framework v2.1.0.0](https://navigation.ros.org/) and the [STVL](https://github.com/SteveMacenski/spatio_temporal_voxel_layer/tree/galactic) plugin through **apt**.

More specifically, we used the **nav2_bringup** simulation, and we added the STVL layers as plugins to the **nav2_params.yaml** (https://navigation.ros.org/tutorials/docs/navigation2_with_stvl.html).

The simulation was run on [Gazebo](https://gazebosim.org/home) and monitored on [RViz2](https://index.ros.org/p/rviz2/).

### 2. Environment Building
To test the STVL plugin, we needed test environments through which to run the simulated robot. For this purpose, Gazebo was used to build the environments and SLAM was used to map them.

### 3. Mapping with SLAM
We chose the SLAM toolbox to map our environments as it was the quickest option available to us. The toolbox was installed through apt, following the nav2 documentation ["Navigating While Mapping"](https://navigation.ros.org/tutorials/docs/navigation2_with_slam.html).  
<br>
With turtlebot3, running SLAM is very simple: the turtlebot3 simulation is called through its launch file, as per usual, but the slam parameter is set to true.
Then, using [teleop_twist_keyboard](http://wiki.ros.org/teleop_twist_keyboard), we explored the entire environment whilst mapping it, and then we saved the map through the map_saver_cli node, as detailed in the nav2 documentation ["Map Saver / Saver"](https://navigation.ros.org/configuration/packages/configuring-map-server.html).

## Testing
Our costmap inflation layer was configured to use a radius of 0.40. The RGBD camera equipped on turtlebot3 was configured to have a horizontal FOV of 180°.
<br>
STVL can be configured to use different voxel sizes, meaning different levels of resolution in representing 3D environments. 

### Test 1
For our **first test**, the **difference in CPU consumption** given **three different voxel sizes (0.01m, 0.05m, 0.1m)** was measured. This was done by instructing the robot to navigate to the same specific waypoints, each time with different STVL voxel sizes. The CPU consumption was measured during each run, and the differences were extracted. This was then repeated on a total of two different test environments.

| Voxel Size | CPU consumption (%) |
| ---------- | ------------------- |
| 0.01       | 43.5                |
| 0.05       | 42.1                |
| 0.1        | 38.0                |

Unexpectedly, the difference in CPU consumption given different voxel sizes is quite negligible, and is completely overshadowed by the results obtained in the next test.

### Test 2
STVL introduces the concept of voxel decay time, which determines how long each voxel will stay in memory for before being _forgotten_. The decay time can be configured for both the local and the global STVL layers.
<br>
For our **second test**, the **RAM consumption** was monitored, given the same waypoints and maps as in the first test, but with the voxels in the global layer set to **never decay** and the ones in the local layer set to a 5 second decay time. This was done to measure the rate of RAM consumption over time, given different voxel sizes, and the results were interesting:

| Voxel Size | RAM consumption  |
| ---------- | ---------------- |
| 0.1        | Very reasonable  |
| 0.05       | Moderate |
| 0.01       | Extremely high |

On a system with 16GB of RAM, the memory ran out after only one minute of simulation. This proves that it is very important to set a proper voxel decay time, so as to avoid a system crash. Of course, STVL was never meant to be used this way, and this was just a stress test. Mapping with STVL is indeed possible, but it is done by setting activating the **mapping mode** (i.e. setting mapping to TRUE in the params.yaml file). More on this below. 

### Other observations
Some other interesting observations were made:
1. A bigger voxel size actually makes it harder for the robot to navigate tight corridors and pathways, because the limited space gets limited even further by overestimating obstacle sizes.
2. By activating mapping mode, hundreds of thousands of voxels can be saved and viewed in just a few MBs (yes, Megabytes!) of data, using the **vdb_viewer** from [OpenVDB](https://www.openvdb.org/) (an open-source C++ library from DreamWorks which is at the core of STVL).
3. In its default configuration, STVL actually sees floating voxels as obstacles, because the costmap projects them onto the floor. This means that small robots like turtlebot3 cannot navigate underneath empty spaces with an overhang, like tables or door frames. A solution that we have found around this issue is configuring two separate STVL layers: one for navigation, which only "sees" obstacles that are of the same height of the robot, and another layer which maps the whole environment around the robot. 
4. Moving obstacles are correctly visualised, but it is important to deactivate the global stvl layer and to set the local stvl layer to a very low value of voxel_decay

### Conclusions
STVL requires a lot of configuration and tuning to properly work, but is a very powerful plugin that is much more computationally efficient than the default nav2 voxel layer. It is versatile, as it can be used for simultaneous navigation and mapping, and it provides a very memory-efficient way of storing mapped data. 

## Encountered Issues
We found the documentation to be too superficial, both for navigation2 and STVL. A lot of things had to be discovered by trial-and-error, which requires a lot of time.
<br>
Another big issue that we encountered was in trying to use a simulated version of TIAGo in our environments (since the experimental tests were conducted on TIAGo). STVL and Navigation2 are intended for ROS2, but TIAGo runs on ROS1. We looked around quite thoroughly around [PAL Robotics' official GitHub](https://github.com/pal-robotics/), and although they provide numerous simulations and tutorials for ROS1 (understandably), their ROS2 branches are still in development and their .rosinstall files are not usable by unauthorised people. Additionally, there was no tutorial on running their simulations on ROS2. We tried manually scouring through their repositories and cross-checking .rosinstall files to try and find all the necessary dependencies required to run their simulations, which we then installed manually one by one, but after dozens of additional required dependencies and failed attempts, we just gave up on this path. 

<br>
One thing to note, though: a simulation of **TIAGo Iron** on ROS2 does exist for [WeBots](https://cyberbotics.com/), but there were several issues.
<br>
First of all, the RGBD camera is wrongly rotated.
<br>
Secondly, RViz insisted on listening to the wrong camera_info topic, so we had to write a node that republished all camera-related information towards said topic.
<br>
Even after finally correcting all camera-related issues, the STVL layer would not be displayed on RViz, giving no apparent errors. Instead of spending more time on this route, we decided to simply go back to what already worked well: applying STVL to turtlebot3 on Gazebo. This was much more time-effective as it allowed us to focus on the tests themselves.
