#!/bin/bash
cd ~/auto_run
echo -n "Are the ROS and MATLAB installed at one computre? y/n:"
read yn
if [ "$yn" = "n" ]; then
    echo -n "please input the IP of computer installed ROS:"
    read ip
    echo "ROS_HOSTNAME=$ip"
    export ROS_HOSTNAME=$ip
fi



echo -n  "please enter the number of uav=: "
read  num

roslaunch hector_quadrotor_gazebo load_gazebo_world.launch & PID0=$!
sleep 3

python generate_launch.py
sleep 3
source ~/catkin_ws/devel/setup.zsh
roslaunch hector_quadrotor_gazebo gen_spawn_$num.launch & PID1=$!
sleep 3

for i in $(seq 1 $num);
do
    echo " uav$i armed.";
    #echo "rosservice call /uav$i/enable_motors true"
    rosservice call /uav$i/enable_motors true
    sleep 1
done
sleep 2

# python pub_multiple_pose.py
echo "load all model and parameters."

wait

kill PID1
kill PID0

exit



