global uav_num % number of UAV
global ros_sub_pub_name  % variable name of ros subscriber and publisher for subscribe data and send command.
global ros_topic_name   % The name of navigation data topics and command topics.

ros_topic_name = cell(uav_num,3);
for i=1:uav_num

    uav_name = ['/bebop',num2str(i)];        % e.g. /uav1 /uav2 ...
    navdata_pos_name = '/pos_sync';
    navdata_vel_name = '/vel_sync';
    vel_cmd_name = '/velocity_cmd';
    ros_topic_name{i}{1}=[uav_name,navdata_pos_name];
    ros_topic_name{i}{2}=[uav_name,navdata_vel_name];
    ros_topic_name{i}{3}=[uav_name,vel_cmd_name];
    ros_sub_pub_name{i}{1} = rossubscriber(ros_topic_name{i}{1});                                %  subscriber : get navdata from uav
    ros_sub_pub_name{i}{2} = rossubscriber(ros_topic_name{i}{2});
    ros_sub_pub_name{i}{3} = rospublisher(ros_topic_name{i}{3},rostype.geometry_msgs_Twist);     %  publisher : send velocity cmd to uav
   
    pause(3);
end
