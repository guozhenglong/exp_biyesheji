function cmd_vel_send(uav_id, vx_d, vy_d, vz_d,v_yaw_d)
%% send velocity command to the uav_id uav.
    global ros_sub_pub_name
    cmd_vel_msg = rosmessage(ros_sub_pub_name{uav_id}{3});
    cmd_vel_msg.Linear.X = vx_d; 
    cmd_vel_msg.Linear.Y = vy_d;
    cmd_vel_msg.Linear.Z = vz_d;
    cmd_vel_msg.Angular.Z = v_yaw_d;
    send(ros_sub_pub_name{uav_id}{3},cmd_vel_msg);
end
