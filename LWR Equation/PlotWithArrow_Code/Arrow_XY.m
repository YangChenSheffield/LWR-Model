function [X0 Y0 Xi Yi X_y Y_x] = Arrow_XY(rec,pos)   
% [X0 Y0 Xi Yi X_y Y_x] = Arrow_XY(rec,pos)
% ȷ����ͷ����ʼλ��
% ���룺 rec  Ϊaxes������ռ�ľ�������
%        pos  ���ڿ����������λ��,�����plot_with_arrow��posΪnʱ��ͷ����
% ����� [X0 Y0 Xi Yi X_y Y_x] �������ͷ����ʼ����
%                                ��(X_y,Yi) 
%           ---------------------��----------------------  ���ο��Ӧ������ߴ磬��recȷ��
%          |                     ��                     | 
%          |                     ��                     | 
%      ���������������������������������������������������������� 
% (X0,Y_x) |                     ��                     | (Xi,Y_x)
%          |                     ��                     | 
%          ----------------------��---------------------- 
%                                ��(X_y,Y0) 
% By ZFS@wust 2012.04.19
% See Also: Arrow_Xlabel, Arrow_Ylabel, plot_with_arrow
% ��ȡ����Matlab/Simulinkԭ�����Ϻͳ������ע΢�Ź��ںţ�Matlab Fans




dr1 = 0.1*rec(3);  % ������ȱ���
dr2 = 0.1*rec(4);  % �������ȱ���

% pos(1) ȷ��X��λ��
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

% pos(2) ȷ��Y��λ��
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

Xi = min(Xi,1); % �������ֵΪ1
Yi = min(Yi,1);
