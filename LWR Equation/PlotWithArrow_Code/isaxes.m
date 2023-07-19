function flag = isaxes(h)   
% flag = isaxes(h)
% 判断h是否为坐标轴句柄
% See Also: isfigure， plot_with_arrow
% 获取更多Matlab/Simulink原创资料和程序，清关注微信公众号：Matlab Fans

if ishandle(h)
    if strcmp( 'axes' , get(h,'type') )
       flag = 1;
    else
        flag = 0;
    end
else
    flag = 0;
end;