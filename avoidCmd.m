function cmd = avoidCmd(distance,rm,ra,e)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    d = norm(distance);

    f = sig(d,rm,ra);
    g = (1+e)*d-2*rm*s_m(d/(2*rm));
    f_grad = grad_sig(d,rm,ra);
    g_grad = (1+e)-grad_s_m(d/(2*rm));

    V = (f_grad*g-f*g_grad)/(g*g);

    cmd = -distance/d*V;

end

function  y = sig(x,d1,d2)
    if (x<d1)
        y=1.0;
    elseif (x>d2)
        y= 0.0;
    else
        y=(d2-x)/(d2-d1);
    end
end

function y = grad_sig(x,d1,d2)
    if (x<d1)
        y= 0.0;
    elseif (x>d2)
        y=0.0;
    else
        y=-1.0/(d2-d1);
    end
end

function y = s_m(x)
    if (x<1.0)
        y=x;
    else
        y=1.0;
    end
end

function y = grad_s_m(x)
    if (x<1.0)
        y = 1.0;
    else
        y=0.0;
    end
end
