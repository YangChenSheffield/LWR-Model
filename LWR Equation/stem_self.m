function h_p = stem_self(ha,x,y,color)
% 自定义stem函数，去除系统函数中的0位线，不适合大数据量绘图
% 返回值为线条句柄数组和mark圆句柄
% 获取更多Matlab/Simulink原创资料和程序，清关注微信公众号：Matlab Fans

axes(ha);
hold on
n = length(x);
for ii = 1:n
   h_p(ii) = line([x(ii) x(ii)],[0 y(ii)],'color',color );
end

h_o = plot(ha,x,y,'o');
set(h_o,'color',color);

h_p = [h_p h_o];