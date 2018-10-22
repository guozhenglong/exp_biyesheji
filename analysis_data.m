
load record_data.mat
[height,length] = size(debug_data);
bebop1_flight_data = zeros(length,19);
bebop2_flight_data = zeros(length,19);
bebop3_flight_data = zeros(length,19);
for i=1:length
    bebop1_flight_data(i,:) = debug_data{1,i}(1,:);
    bebop2_flight_data(i,:) = debug_data{2,i}(1,:);
    bebop3_flight_data(i,:) = debug_data{3,i}(1,:);
    i
end