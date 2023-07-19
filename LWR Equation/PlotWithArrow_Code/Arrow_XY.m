function [X0 Y0 Xi Yi X_y Y_x] = Arrow_XY(rec,pos)   
% [X0 Y0 Xi Yi X_y Y_x] = Arrow_XY(rec,pos)
% 确定箭头的起始位置
% 输入： rec  为axes对象所占的矩形区域
%        pos  用于控制坐标轴的位置,意义见plot_with_arrow，pos为n时箭头反向
% 输出： [X0 Y0 Xi Yi X_y Y_x] 坐标轴箭头的起始坐标
%                                ↑(X_y,Yi) 
%           ---------------------↑----------------------  矩形框对应坐标轴尺寸，由rec确定
%          |                     ↑                     | 
%          |                     ↑                     | 
%      →→→→→→→→→→→→→→↑→→→→→→→→→→→→→→ 
% (X0,Y_x) |                     ↑                     | (Xi,Y_x)
%          |                     ↑                     | 
%          ----------------------↑---------------------- 
%                                ↑(X_y,Y0) 
% By ZFS@wust 2012.04.19
% See Also: Arrow_Xlabel, Arrow_Ylabel, plot_with_arrow
% 获取更多Matlab/Simulink原创资料和程序，清关注微信公众号：Matlab Fans




dr1 = 0.1*rec(3);  % 超出宽度比例
dr2 = 0.1*rec(4);  % 超出长度比例

% pos(1) 确定X轴位置
if pos(1) == 'p'
     X_y = rec(1);
     X0 = rec(1);
     Xi = rec(1) + rec(3) + dr1;
elseif pos(1) == 'a'
     X_y = rec(1) + 0.5*rec(3);
     X0 = rec(1) - dr1/2;
     Xi = rec(1) + rec(3) + dr1/2;
elseif pos(1) == 'n'
     X_y = rec(1) + rec(3);
     X0 = rec(1) + rec(3);
     Xi = rec(1) - dr1;
end

% pos(2) 确定Y轴位置
if pos(2) == 'p'
     Y_x = rec(2);
     Y0 = rec(2);
     Yi = rec(2) + rec(4) + dr2;
elseif pos(2) == 'a'
     Y_x = rec(2) + 0.5*rec(4);
     Y0 = rec(2) - dr2/2;
     Yi = rec(2) + rec(4) + dr2/2;
elseif pos(2) == 'n'
     Y_x = rec(2) + rec(4);
     Y0 = rec(2) + rec(4);
     Yi = rec(2) - dr2;
end

Xi = min(Xi,1); % 限制最大值为1
Yi = min(Yi,1);
