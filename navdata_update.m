function navdata = navdata_update()
    global uav_num
    global ros_sub_pub_name
    navdata = zeros(uav_num,9);% x, y, z, roll, pitch, yaw, vx, vy, vz
    
    %% read the data from ros
    for i=1:uav_num
        % position: x, y, z in the world coordiante of gazebo world. 
        p_x = ros_sub_pub_name{i}{1}.LatestMessage.Pose.Position.X;
        p_y = ros_sub_pub_name{i}{1}.LatestMessage.Pose.Position.Y;
        p_z = ros_sub_pub_name{i}{1}.LatestMessage.Pose.Position.Z;
        navdata(i,1) = p_x;
        navdata(i,2) = p_y;
        navdata(i,3) = - p_z;

        % attitude (quaternion): first get quaternion, second transform to euler angle.
        q_x = ros_sub_pub_name{i}{1}.LatestMessage.Pose.Orientation.X;
        q_y = ros_sub_pub_name{i}{1}.LatestMessage.Pose.Orientation.Y;
        q_z = ros_sub_pub_name{i}{1}.LatestMessage.Pose.Orientation.Z;
        q_w = ros_sub_pub_name{i}{1}.LatestMessage.Pose.Orientation.W;
        euler_RPY = quat2eul([q_x,q_y,q_z,q_w]);  % transform to euler angle.
        navdata(i,4:6) = euler_RPY; 
        navdata(i,6) = - navdata(i,6);

        % linear velocity: vx vy vz
        v_x = ros_sub_pub_name{i}{2}.LatestMessage.Pose.Position.X;
        v_y = ros_sub_pub_name{i}{2}.LatestMessage.Pose.Position.Y;
        v_z = ros_sub_pub_name{i}{2}.LatestMessage.Pose.Position.Z;
        navdata(i,7) = v_x;
        navdata(i,8) = v_y;
        navdata(i,9) = -v_z;

    end

end
