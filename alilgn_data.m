[height,length] = size(debug_data);
align_debug_data = cell(3,length/3);
k=1;
for i=1:3:length
    for j=1:3
        align_debug_data{j,k} = debug_data{j,i+j-1};
    end
    k=k+1;
end