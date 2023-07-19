function flag = isfigure(h) 
% flag = isfigure(h) 
% 判断h是不是图形句柄
% See Also: isaxes, plot_with_arrow
% 获取更多Matlab/Simulink原创资料和程序，清关注微信公众号：Matlab Fans

if ishandle(h)
    if strcmp( 'figure' , get(h,'type') )
       flag = 1;
    else
        flag = 0;
    end
else
    flag = 0;
end

end