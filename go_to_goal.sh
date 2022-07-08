#!/bin/bash

ros2 action send_goal /NavigateToPose nav2_msgs/action/NavigateToPose "pose: {header: {frame_id: map}, pose: {position: {x: $1, y: $2, z: 0.0}, orientation:{x: 0.0, y: 0.0, z: $3, w: $4}}}"
