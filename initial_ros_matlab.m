%% initial the toolbox of Robotics of MATLAB, and connect the ROS environment and MATLAB. 

% if matlab and gazebo are installed in one computer, matlab_ros should be set to 0;
% else matlab_ros need set to 1.

matlab_ros = 0;
if(matlab_ros)
    setenv('ROS_MASTER_URI','http://192.168.0.5:11311')   % the IP of gazebo server (computer installed ROS) 
    setenv('ROS_IP','192.168.0.3')    % the IP of matlab client (computer installed MATLAB)
    try
        rosinit('http://192.168.0.5:11311') % replace the IP of gazebo server (computer installed ROS) 
    end
else
    try
        rosinit;
    end
end
