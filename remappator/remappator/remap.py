# Copyright 2016 Open Source Robotics Foundation, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import rclpy
from rclpy.node import Node

from sensor_msgs.msg import CameraInfo


class MinimalPublisher(Node):

    def __init__(self):
        super().__init__('minimal_publisher')
        self.publisher_ = self.create_publisher(
        CameraInfo,
        '/TIAGo_Iron/camera_info',
         1)

    def callback(self, msg):
        self.publisher_.publish(msg)
        #self.get_logger().info('Publishing: "%s"' % msg.data)

class MinimalSubscriber(Node):
    
    def __init__(self):
        super().__init__('minimal_subscriber')
        minimal_publisher = MinimalPublisher()
        self.subscription = self.create_subscription(
            CameraInfo,
            '/TIAGo_Iron/camera/camera_info',
            minimal_publisher.callback,
            1)
        self.subscription  # prevent unused variable warning
        
    #def callback(self, msg):
        


def main(args=None):
    rclpy.init(args=args)   

    minimal_subscriber = MinimalSubscriber()

    rclpy.spin(minimal_subscriber)

    # Destroy the node explicitly
    # (optional - otherwise it will be done automatically
    # when the garbage collector destroys the node object)
    minimal_publisher.destroy_node()
    minimal_subscriber.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()
