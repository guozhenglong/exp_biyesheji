[height,length] = size(debug_data);
align_debug_data = cell(3,length/3);

for i=1:length
    uav_i = mod(i,3)+1;
    data_i = floor(i/3)+1
    debug_data{uav_i,i}
    align_debug_data{uav_i,data_i} = debug_data{uav_i,i};
end