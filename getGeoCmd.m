function GeoCmd = getGeoCmd(navdata,num,l,rm,x_min,x_max,y_min,y_max)
    geo_mid_x = (x_min+x_max)/2;
    geo_mid_y = (y_min+y_max)/2;
    GeoCmd = zeros(3,num);
    dis_vec = zeros(3,num);
    for i=1:num
        dis_vec(:,i) = navdata(i,1:3)'+l*navdata(i,7:9)';

        dis_geo_x = dis_vec(1,i) - geo_mid_x;
        cmd_geo_x = generateGeoCmd(dis_geo_x,x_max,rm);

        dis_geo_y = dis_vec(2,i) - geo_mid_y;
        cmd_geo_y = generateGeoCmd(dis_geo_y,y_max,rm);
        
        GeoCmd(1,i) = cmd_geo_x;
        GeoCmd(2,i) = cmd_geo_y;
        GeoCmd(3,i) = 0;
    end
end

function geo_cmd=generateGeoCmd(dis,max,rm)
    if(dis >= 0.0)
        sgn = -1;
    else
        sgn = 1;
    end

    if(abs(dis)<max-rm)
      V = 0;
    else
      V = 10.0/rm*(abs(dis) -( max-rm));
    end
    geo_cmd = sgn*V;

end