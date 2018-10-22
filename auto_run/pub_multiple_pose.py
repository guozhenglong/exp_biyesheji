#!/usr/bin/env python
#-*-coding:utf-8 -*-
import rospy
import sys
import time
from std_msgs.msg import Header
from geometry_msgs.msg import Twist

def takeoff_finished():
      print("Takeoff Completed!")

def fly2goal(drone_num, X,Y,Z,Yaw):
	rospy.init_node('fly2goal', anonymous=True)
	rate = rospy.Rate(30)
	pub_topic_name = []
	pub_pose_cmd = []
	k=0
	for i in range(drone_num):
		name_topic = "/uav"+str(i+1)+"/pose_cmd"
		pub_topic_name.append(name_topic)
		pub_pose_cmd.append(rospy.Publisher(name_topic, Twist, queue_size=100))
		print(i+1)
	while not rospy.is_shutdown():
		k=k+1
		# print(k)
		for i in range(drone_num):
			pose_vel_ctrl = Twist()
			pose_vel_ctrl.linear.x = X[i]
			pose_vel_ctrl.linear.y = Y[i]
			pose_vel_ctrl.linear.z = Z[i]
			pose_vel_ctrl.angular.x = 0.0
			pose_vel_ctrl.angular.y = 0.0
			pose_vel_ctrl.angular.z = Yaw[i]
			pub_pose_cmd[i].publish(pose_vel_ctrl)
		if(k>200):
			rospy.on_shutdown(takeoff_finished)
            		time.sleep(3)
            		sys.exit()
		rate.sleep()

if __name__ == '__main__':
	# drone_num = 4
	# X = [1,2,3,4]
	# Y = [0,0,0,0]
	with open('three_drones.txt', 'r') as f:
		data = f.read()
	strlist = data.split('\n')

	str_x = strlist[0]
	list_x = str_x.split(',')
	X = list(map(int, list_x))
	print(X)

	str_y = strlist[1]
	list_y = str_y.split(',')
	Y = list(map(int, list_y))
	print(Y)

	str_z = strlist[2]
	list_z = str_z.split(',')
	Z = list(map(int, list_z))
	print(Z)

	str_yaw = strlist[3]
	list_yaw = str_yaw.split(',')
	Yaw = list(map(int, list_yaw))
	print(Yaw)

	drone_num = len(X)

	for i in range(drone_num):
		print("The expected position of uav ",i," := (",X[i],",",Y[i],")")
	fly2goal(drone_num, X,Y,Z,Yaw)
