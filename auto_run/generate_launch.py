#!/usr/bin/env python
#-*-coding:utf-8 -*-
from xml.dom import minidom
def generateXml(model_path,uav_num,include_path,x,y):
	impl = minidom.getDOMImplementation()
	doc = impl.createDocument(None, None, None)

	rootElement = doc.createElement('launch')
	childElement = doc.createElement('arg')
	childElement.setAttribute('name', 'model')
	childElement.setAttribute('value', model_path)
	rootElement.appendChild(childElement)

	for i in range(uav_num):
		group_Element = doc.createElement('group')
		group_name = "uav" + str(i+1)
		group_Element.setAttribute('ns', group_name)
		include_childelement = doc.createElement("include")
		include_childelement.setAttribute('file', include_path)

		name_childelement = doc.createElement("arg")
		name_childelement.setAttribute('name', "name")
		name_childelement.setAttribute('value', group_name)

		prefix_childelement = doc.createElement("arg")
		prefix_childelement.setAttribute('name', "tf_prefix")
		prefix_childelement.setAttribute('value', group_name)

		model_childelement = doc.createElement("arg")
		model_childelement.setAttribute('name', "model")
		model_childelement.setAttribute('value', "$(arg model)")

		x_childelement = doc.createElement("arg")
		x_childelement.setAttribute('name', "x")
		x_childelement.setAttribute('value', str(x[i]))

		y_childelement = doc.createElement("arg")
		y_childelement.setAttribute('name', "y")
		y_childelement.setAttribute('value', str(y[i]))

		include_childelement.appendChild(name_childelement)
		include_childelement.appendChild(prefix_childelement)
		include_childelement.appendChild(model_childelement)
		include_childelement.appendChild(x_childelement)
		include_childelement.appendChild(y_childelement)

		group_Element.appendChild(include_childelement)
		rootElement.appendChild(group_Element)
	doc.appendChild(rootElement)
	ws_path = "/home/zhenglong/catkin_ws"
	dst_path = "/src/hector_quadrotor/hector_quadrotor_gazebo/launch/"
	file_name = "gen_spawn_"+str(uav_num)+".launch"
	f = open(ws_path+dst_path+file_name, 'w')
	doc.writexml(f, addindent=' ', newl='\n')
	f.close()

if __name__ == '__main__':
	model_path = "$(find hector_quadrotor_description)/urdf/quadrotor.gazebo.xacro"
	include_path = "$(find hector_quadrotor_gazebo)/launch/spawn_quadrotor.launch"
	#x=[1,2,3,4,5,6,7,8]
	#y=[0,1,2,3,4,5,6,7]
	#uav_num = len(x)

	with open('three_drones.txt', 'r') as f:
		data = f.read()
	strlist = data.split('\n')
	str_x = strlist[0]
	list_x = str_x.split(',')
	str_y = strlist[1]
	list_y = str_y.split(',')
	x = list(map(int, list_x))
	y = list(map(int, list_y))
	uav_num = len(x)

	for i in range(uav_num):
		print("The position of uav ",i," := (",x[i],",",y[i],")")

	generateXml(model_path,uav_num,include_path,x,y)
