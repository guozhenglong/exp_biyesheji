function AvoidanceCmd = getAvoidanceCmd(position, velocity,num,l,rm,ra,e)
% position velocity: 3xn
%   �˴���ʾ��ϸ˵��
    distans = cell(num,num);
    cmd_all = zeros(3,num);
    for i =1:num
        for j=1:num
           dis = zeros(3,1);
           for k =1:3
               dis(k,1) = (position(k,i)-position(k,j))+l*(velocity(k,i)-velocity(k,j));
           end
           distans{i,j}= dis;
        end
        k=1;
        cmd_i =  zeros(3,1);
        while(k<=num)
            if(i~=k)
                cmd_i = cmd_i + avoidCmd(distans{i,k}, rm,ra,e); % 3x1
            end
            k= k+1;
        end
        cmd_all(:,i) = cmd_i;
    end
    AvoidanceCmd = cmd_all;
end

