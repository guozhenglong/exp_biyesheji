rosshutdown;
clear;
clc;
close all;
%% Send velocity comand and drive the uav to the target point. 
global uav_num 
uav_num = 3;
% connect MATLAB and ROS(gazebo)
initial_ros_matlab;  
% definition of some variable for recieving navdata and sending command. 
ROS_nodehandle;  
ardrone_control;
prompt = 'Start the flight task.Are the bebops flying?  1:yes;0:no. please input 1 or 0 ?';
x = input(prompt);
if x==1
    
% set the position and yaw of target point
uav_destination=zeros(uav_num,4);
% uav_destination(1,:)  = [0.2,0.3,3.0,0.0];
% uav_destination(2,:)  = [-4.0,4.0,3.0,0.0];
% uav_destination(3,:)  = [5.0,-5.0,3.0,0.0];

% uav_destination(1,:)  = [0.2,0.3,3.0,0.0];
% uav_destination(2,:)  = [4.0,-4.0,3.0,0.0];
% uav_destination(3,:)  = [-5.0,5.0,3.0,0.0];


% uav_destination(1,:)  = [0.1,0.3,3.0,0.0];
% uav_destination(2,:)  = [-4.0,-5.0,3.0,0.0];
% uav_destination(3,:)  = [5.0,5.0,3.0,0.0];

% uav_destination(1,:)  = [0.1,0.3,1.0,0.0];
% uav_destination(2,:)  = [1.0,2.0,1.0,0.0];
% uav_destination(3,:)  = [-1.2,-1.3,1.0,0.0];
% 

uav_destination(2,:)  = [-0.3,-0.3,1.2,0.0];
uav_destination(1,:)  = [1.0,2.0,1.2,0.0];
uav_destination(3,:)  = [-1.2,-3.0,1.2,0.0];

uav_wp = cell(3,10);
for cnt=1:10
   if mod(cnt,2)==1
        uav_wp{2,cnt}  = [-0.3,-0.3,1.2,0.0];
        uav_wp{1,cnt}  = [1.0,2.0,1.2,0.0];
        uav_wp{3,cnt}  = [-1.2,-3.0,1.2,0.0]; 
   else
        uav_wp{2,cnt}  = [0.3,0.3,1.2,0.0];
        uav_wp{3,cnt}  = [1.0,2.0,1.2,0.0];
        uav_wp{1,cnt}  = [-1.2,-3.0,1.2,0.0]; 
   end
end

l = 0.1;
rm = 0.2;
ra = 1.2;
e = 0.01;
Vmax = 0.3;
bound = 3.5;
x_min = -1*bound;
x_max = bound;
y_min = -1*bound;
y_max = 2;
% p_xy = 0.6;
% d_xy = 0.4;
p_x = 0.6;
p_y = 0.6;
p_z = 0.5;
p_yaw = 0.0;
% 
% x_d = 1.0;
% y_d = 2.0;
% z_d = 3.0;
% yaw_d = 0.5;
% pos_d = [x_d, y_d,z_d];
navdata = navdata_update();  % x y z roll pitch yaw vx vy vz
GeoCmd = getGeoCmd(navdata,uav_num,l,rm,x_min,x_max,y_min,y_max);
pause(2);
debug_data = cell(3,10000);
k=1;
cnt = 1;
while (cnt<11)
    position = navdata(:,1:3)';
    velocity = navdata(:,7:9)';
    AvoidanceCmd = getAvoidanceCmd(position, velocity,uav_num,l,rm,ra,e);
    if (norm(navdata(1,1:3)-uav_wp{i,cnt}(1,1:3))>0.1 || abs(navdata(1,6)-uav_wp{1,cnt}(1,4))>0.1) && ...
            (norm(navdata(2,1:3)-uav_wp{2,cnt}(1,1:3))>0.1 || abs(navdata(2,6)-uav_wp{2,cnt}(1,4))>0.1) && ...
            (norm(navdata(3,1:3)-uav_wp{3,cnt}(1,1:3))>0.1 || abs(navdata(3,6)-uav_wp{3,cnt}(1,4))>0.1)
        for i=1:uav_num
        %when the error of position and yaw is large than the threshold
            %Controller
            cmd = zeros(2,1);
            cmd(1,1) = p_x*(uav_wp{i,cnt}(1,1) - navdata(i,1)) + AvoidanceCmd(1,i) + GeoCmd(1,i);
            cmd(2,1)  = p_y*(uav_wp{i,cnt}(1,2) - navdata(i,2)) + AvoidanceCmd(2,i) + GeoCmd(2,i);
            cmd_z  = p_z*(uav_wp{i,cnt}(1,3) - navdata(i,3)) + AvoidanceCmd(3,i) + GeoCmd(3,i);
%             cmd_x = p_x*(uav_destination(i,1) - navdata(i,1));
%             cmd_y = p_y*(uav_destination(i,2) - navdata(i,2));
%             cmd_z = p_z*(uav_destination(i,3) - navdata(i,3));
            if norm(cmd)> Vmax
                cmd = cmd*Vmax/norm(cmd);
            end
            disp(cmd)
            cmd_x = cmd(1,1);
            cmd_y = cmd(2,1);
           
            cmd_yaw = p_yaw*(uav_wp{i,cnt}(1,4)  - navdata(i,6));
            % send the velocity command.
            cmd_vel_send(i,cmd_x, cmd_y,cmd_z,cmd_yaw);  
            cmd_final = [cmd_x, cmd_y,cmd_z,cmd_yaw];
            disp('nacdata:=')
            disp(navdata(i,:))
            disp('GeoCmd:=')
            disp(GeoCmd(:,i))
            disp('AvoidanceCmd:=')
            disp(AvoidanceCmd(:,i))
            debug_data{i,k}=[navdata(i,:),GeoCmd(:,i)',AvoidanceCmd(:,i)',cmd_final];    
        end
        k=k+1;
    else
        cnt = cnt + 1;
    end
 
    disp('send once command.')
    navdata = navdata_update(); % update the navigation data
    GeoCmd = getGeoCmd(navdata,uav_num,l,rm,x_min,x_max,y_min,y_max);

end
end
