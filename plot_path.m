
i = 1000;
% i-1
figure()
plot3(bebop1_flight_data(1:i-1,1),bebop1_flight_data(1:i-1,2),bebop1_flight_data(1:i-1,3),'r');hold on;
plot3(bebop2_flight_data(1:i-1,1),bebop2_flight_data(1:i-1,2),bebop2_flight_data(1:i-1,3),'g');hold on;
plot3(bebop3_flight_data(1:i-1,1),bebop3_flight_data(1:i-1,2),bebop3_flight_data(1:i-1,3),'b');grid on;
% 115
figure()
plot(bebop1_flight_data(1:i-1,1),bebop1_flight_data(1:i-1,2),'r');hold on;
plot(bebop2_flight_data(1:i-1,1),bebop2_flight_data(1:i-1,2),'g');hold on;
plot(bebop3_flight_data(1:i-1,1),bebop3_flight_data(1:i-1,2),'b');grid on;hold on;
plot(0.3,0.3,'*g');hold on;
plot(1.0,2.0,'*b');hold on;
plot(-1.2,-3.0,'*r');hold on;
