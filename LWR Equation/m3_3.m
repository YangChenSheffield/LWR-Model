clear all;
clc;
close all;

%% Time-Space diagram
t=0:0.001:10;
t=t';
x1=-1*t.*(t-10);
figure;
% 添加箭头
plot(t,x1);
hold on;
grid on;
plot([5,5],[0,25],'--b');
plot([0,5],[25,25],'--b');
axis([0 10 0 30]);

Attribute_Set={'LineWidth',1.5}; % 箭头属性及其取值，设置箭头的宽度为1.5
[h1 h_a h_p h_arrow]=plot_with_arrow([],t,x1,'k',[],[],Attribute_Set);
htext_x=Arrow_Xlabel([],'Density',[]); % x 轴的标签
htext_y=Arrow_Ylabel([],'Flow',[]); % y 轴的标签
% xlabel('Times [s]');
% ylabel('Space [m]');
hold on;
grid on;
plot([5,5],[0,25],'--b');
hold on;
grid on;
plot([0,5],[25,25],'--b');
axis([0 12 0 30]);

ax = gca;
set(ax, 'XTick', []);
set(ax, 'YTick', []);


t=0:0.001:20;
x2=-0.5.*t+10;
figure;
plot(t,x2);
Attribute_Set={'LineWidth',1.5}; % 箭头属性及其取值，设置箭头的宽度为1.5
[h1 h_a h_p h_arrow]=plot_with_arrow([],t,x2,'k',[],[],Attribute_Set);
htext_x=Arrow_Xlabel([],'Density',[]); % x 轴的标签
htext_y=Arrow_Ylabel([],'Mean Speed',[]); % y 轴的标签
axis([0 22 0 12]);

ax = gca;
set(ax, 'XTick', []);
set(ax, 'YTick', []);