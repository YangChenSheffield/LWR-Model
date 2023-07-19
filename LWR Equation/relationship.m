clear all;
clc;
close all;

%% rho and Q
rho=0:0.001:1;
rho=rho';
Q=rho.*(1-rho);
figure;
plot(rho,Q);
% 添加箭头
Attribute_Set={'LineWidth',1.5}; % 箭头属性及其取值，设置箭头的宽度为1.5
[h1 h_a h_p h_arrow]=plot_with_arrow([],rho,Q,'k',[],[],Attribute_Set);
htext_x=Arrow_Xlabel([],'\rho',[]); % x 轴的标签
htext_y=Arrow_Ylabel([],'Q(\rho)',[]); % y 轴的标签

hold on;
grid on;
plot([0.5,0.5],[0,0.25],'--b');
hold on;
grid on;
plot([0,0.5],[0.25,0.25],'--b');
axis([0 1 0 0.3]);

ax = gca;
set(ax, 'XTick', []);
set(ax, 'YTick', []);

saveas(gcf, 'image1.png');

%% rho and speed V
rho=0:0.001:1;
rho=rho';
V=1-rho;
figure;
plot(rho,V);
% 添加箭头
[h2 h_a h_p h_arrow]=plot_with_arrow([],rho,V,'k',[],[],Attribute_Set);
htext_x=Arrow_Xlabel([],'\rho',[]); % x 轴的标签
htext_y=Arrow_Ylabel([],'V(\rho)',[]); % y 轴的标签

hold on;
grid on;
plot([0,1],[0.5,0.5],'--b');
hold on;
grid on;
plot([0.5,0.5],[0,1],'--b');
hold on;
grid on;
plot([1,1],[0,1],'--b');
hold on;
grid on;
plot([0,1],[1,1],'--b');
axis([0 1 0 1]);
ax = gca;
set(ax, 'XTick', []);
set(ax, 'YTick', []);

saveas(gcf, 'image2.png');

%% Q and speed V
Q=rho.*V;
figure;
plot(Q,V);
% 添加箭头
Attribute_Set={'LineWidth',1.5}; % 箭头属性及其取值，设置箭头的宽度为1.5
[h3 h_a h_p h_arrow]=plot_with_arrow([],Q,V,'k',[],[],Attribute_Set);
htext_x=Arrow_Xlabel([],'Q(\rho)',[]); % x 轴的标签
htext_y=Arrow_Ylabel([],'V(\rho)',[]); % y 轴的标签

hold on;
grid on;
plot([0.25,0.25],[0,0.5],'--b');
hold on;
grid on;
plot([0,0.25],[0.5,0.5],'--b');
axis([0 0.3 0 1]);

ax = gca;
set(ax, 'XTick', []);
set(ax, 'YTick', []);

saveas(gcf, 'image3.png');
close all;
