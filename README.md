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

### 2. Tuning

### 3. Testing & Criteria

## Encountered Issues
A big issue that we encountered was in trying to use a simulated version of TIAGo in our environments.

## Results

## Conclusions

## Future considerations
