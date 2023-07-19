clear all;
clc;
close all;

%% Time-Space diagram
t=0:0.001:100;
t=t';
x1=20*t;
x2=15*t-30;
x3=10*t-200
figure;
% 添加箭头

Attribute_Set={'LineWidth',1.5}; % 箭头属性及其取值，设置箭头的宽度为1.5
[h1 h_a h_p h_arrow]=plot_with_arrow([],t,x1,'k',[],[],Attribute_Set);
htext_x=Arrow_Xlabel([],'t',[]); % x 轴的标签
htext_y=Arrow_Ylabel([],'x',[]); % y 轴的标签
xlabel('Times [s]');
ylabel('Space [m]');
plot(t,x1);
hold on;
grid on;
plot(t,x2);
hold on;
grid on;
plot(t,x3);
axis([0 100 0 1200]);
legend('Vehicle A','Vehicle B','Vehicle C');
% ax = gca;
% set(ax, 'XTick', []);
% set(ax, 'YTick', []);

% saveas(gcf, 'image1.png');

%% Time-Traffic flow
% 设置随机数范围和数量
lowerBound = 3000;
upperBound = 8000;
numNumbers = 120;

% 生成一组随机数
numbers = randi([lowerBound, upperBound], 1, numNumbers);

% 随机排列这些数
randomNumbers = numbers(randperm(numNumbers));

figure;
plot(randomNumbers);

% 添加箭头
Attribute_Set={'LineWidth',1.5}; % 箭头属性及其取值，设置箭头的宽度为1.5
[h1 h_a h_p h_arrow]=plot_with_arrow([],[],randomNumbers,'k',[],[],Attribute_Set);
htext_x=Arrow_Xlabel([],'t',[]); % x 轴的标签
htext_y=Arrow_Ylabel([],'Q',[]); % y 轴的标签
xlabel('Times [min]');
ylabel('Traffic flow [veh/h]');
hold on;grid on;
plot(randomNumbers);
axis([0 120 0 9000]);

%% Time-Mean speed
% 设置随机数范围和数量
lowerBound1 = 63;
upperBound1 = 70;
lowerBound2 = 45;
upperBound2 = 60;
numNumbers = 240;

% 生成一组随机数
randomNumbers = zeros(1, numNumbers);
for i = 1:numNumbers
    if i >= 60 && i <= 90
        randomNumbers(i) = randi([lowerBound2, upperBound2]);
    else
        randomNumbers(i) = randi([lowerBound1, upperBound1]);
    end
end

figure;
t=0:0.1:23.9;
plot(t,randomNumbers);

% 添加箭头
Attribute_Set={'LineWidth',1.5}; % 箭头属性及其取值，设置箭头的宽度为1.5
[h1 h_a h_p h_arrow]=plot_with_arrow([],[],randomNumbers,'k',[],[],Attribute_Set);
htext_x=Arrow_Xlabel([],'t',[]); % x 轴的标签
htext_y=Arrow_Ylabel([],'v',[]); % y 轴的标签
xlabel('Times [h]');
ylabel('Mean Speed [miles/h]');
hold on;grid on;
plot(t,randomNumbers);
axis([0 24 40 75]);
