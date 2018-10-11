% load align_debug_data.mat
[height,length] = size(align_debug_data);
bebop1_flight_data = zeros(length,19);
bebop2_flight_data = zeros(length,19);
bebop3_flight_data = zeros(length,19);
for i=1:length
    bebop1_flight_data(i,:) = align_debug_data{1,i}(1,:);
    bebop2_flight_data(i,:) = align_debug_data{2,i}(1,:);
    bebop3_flight_data(i,:) = align_debug_data{3,i}(1,:);
    i
end
% 115
figure()
plot3(bebop1_flight_data(1:115,1),bebop1_flight_data(1:115,2),bebop1_flight_data(1:115,3),'r');hold on;
plot3(bebop2_flight_data(1:115,1),bebop2_flight_data(1:115,2),bebop2_flight_data(1:115,3),'g');hold on;
plot3(bebop3_flight_data(1:115,1),bebop3_flight_data(1:115,2),bebop3_flight_data(1:115,3),'b');grid on;
% 115
figure()
plot(bebop1_flight_data(1:115,1),bebop1_flight_data(1:115,2),'r');hold on;
plot(bebop2_flight_data(1:115,1),bebop2_flight_data(1:115,2),'g');hold on;
plot(bebop3_flight_data(1:115,1),bebop3_flight_data(1:115,2),'b');grid on;