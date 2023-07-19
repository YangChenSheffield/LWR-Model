%% LWR Greenberg
%{
V(rho)=v_f*exp(-rho/rho_max);
Q(rho)=rho*V;
      =rho*(v_f*exp(-rho/rho_max));
Q_rho=v_f*exp(-rho/rho_max)+v_f*rho*exp(-rho/rho_max)(-1/rho_max);
lamda=(Q1-Q2)/(rho1-rho2);
%}
clear all;
clc;
close all;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% initial conditions
% Professor First condition
axis_xt = [0 10 0 20 0 1];
RHO_0 = [0.1, 0.9, 0, 0.4, 0.7, 0.9]';
X0_0 = [1, 2, 3, 4, 5]';

%% t_step_size Set step size for t
t_step_size = 0.0001;

%% x_step_size Set step size for x
x_step_size = 0.01;

%% initial conditions
v_f = 1;
rho_max = 1;
delta=0.0001;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% calculate the values related to RHO1 figure/first part
RHO0=RHO_0;
X0=X0_0;
k=1;
for i=1:length(RHO0)-1
    rho1=RHO0(i,1);
    Q_rho1=calculate_Q_rho(rho1,v_f,rho_max);
    rho2=RHO0(i+1,1);
    Q_rho2=calculate_Q_rho(rho2,v_f,rho_max);

    if Q_rho1>Q_rho2
        lamda(i,1)=calculate_lamda(rho1,rho2,v_f,rho_max);
    elseif Q_rho1<Q_rho2
        insert_RHO1_location(k,1)=i;
        gap=1/32;
        rho_0 = min(rho1, rho2);
        rho_n = max(rho1, rho2);
        num = ceil((rho_n - rho_0) * 32);
        rho_wave2(1,k) = rho_0;

        for j = 1:num
            rho_wave2(j+1,k) = rho_0 + (1/32)*j;
            if rho_wave2(j+1,k) > rho_n
                rho_wave2(j+1,k) = rho_n;
            else
                rho_wave2(j+1,k) = rho_wave2(j+1,k);
            end
            lamda_wave2(j,k) = calculate_lamda(rho_wave2(j,k), rho_wave2(j+1,k),v_f,rho_max);
        end
        k=k+1;
    end    
end

%% x_min1 original
% Define the original matrix A
A=X0_0;
% Define the matrix B to interpolate, and where to interpolate
k = insert_RHO1_location;
g = k;
B = [];

% insert matrix
for i = 1:length(k)
    % partition matrix A
    A1 = A(1:k(i)-1);
    A2 = A(k(i)+1:end);
    B = X0_0(insert_RHO1_location(i,1),1) * ones(length(lamda_wave2(:,i)), 1);
    C = [A1; B; A2];

    % Assign the new matrix C back to the original matrix A
    A = C;
    if i+1 <= length(k)
        k(i+1,1) = g(i+1,1) + length(B)+1;
    end
end

x_min1 = A;

%% RHO1 original
% Define the original matrix A
A=RHO_0;
% Define the matrix B to interpolate, and where to interpolate
B=[];
k = insert_RHO1_location;
g = k;

% insert matrix
for i = 1:length(k)
    % partition matrix A
    A1 = A(1:k(i)-1);
    A2 = A(k(i)+2:end);
    B = flipud(rho_wave2(:,i));
    C = [A1; B; A2];

    % Assign the new matrix C back to the original matrix A
    A = C;
    if i+1 <= length(k)
        k(i+1,1) = g(i+1,1) + length(B) - 2;
    end
end
RHO1=A;
%% lamda1 original
for i=1:length(RHO1)-1
    rho1=RHO1(i,1);
    rho2=RHO1(i+1,1);
    lamda1(i,1) = calculate_lamda(rho1,rho2,v_f,rho_max);
end

%% find t_min1
t_min1=axis_xt(1);

%% find intersection points t_min2
% Find intersection points
X=[];
T=[];
for i = 1:length(lamda1)-1
    [X(i,1),T(i,1)] = intersection_point(lamda1(i,1), lamda1(i+1,1), -lamda1(i,1)*t_min1+x_min1(i,1), -lamda1(i+1,1)*t_min1+x_min1(i+1,1));
end

%% Find the minimum value of t_min2
t_min2 = min(T(T>t_min1));

%% Find the location of t_min2
t_min2_location = find(abs(T-t_min2)<delta);
% Find the value of delete_RHO1
delete_RHO1 = RHO1(t_min2_location+1, 1);

% Delete the repeated x_t_min1,and get the new x_min1
x_min2 = zeros(length(lamda1)-1, 1);
for i = 1:length(lamda1)
    x_min2(i,1) = lamda1(i,1)*(t_min2-t_min1)+x_min1(i,1);
end
x_min2(t_min2_location,:) = [];

%%  find the new rho of the next part
% Find the new rho of part 2
delete_RHO2_location = t_min2_location + 1;
RHO_new = RHO1;
RHO_new(delete_RHO2_location, :) = [];
RHO2 = RHO_new;

%% plot the figure of RHO1
figure;
draw_3d_figures(x_step_size, axis_xt, t_min1, t_step_size, t_min2, lamda1, x_min1, RHO1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% calculate the values related to RHO2 figure/second part
%% calculate the lamda2 of RHO2 figure/second part
% Calculate lamda2
for i = 1:length(RHO2)-1
    rho1=RHO2(i,1);
    rho2=RHO2(i+1,1);
    lamda2(i,1) = calculate_lamda(rho1, rho2,v_f,rho_max);
end

%% calculate the values of t_min3, delete_RHO2, x_min3,t_min3_location
% Find intersection points
X=[];
T=[];
for i = 1:length(lamda2)-1
    [X(i,1),T(i,1)] = intersection_point(lamda2(i,1), lamda2(i+1,1), -lamda2(i,1)*t_min2+x_min2(i,1), -lamda2(i+1,1)*t_min2+x_min2(i+1,1));
end

% Find the minimum value of t
if length(RHO2)>2
    t_min3 = min(T(T>t_min2));
else
    t_min3 = axis_xt(4);
end

if length(RHO2)>2
    % Find the location of t_min3
    t_min3_location = find(abs(T-t_min3)<delta);
    
    % Find the value of delete_RHO2
    delete_RHO2 = RHO2(t_min3_location+1, 1);
    
    % Delete the repeated x_t_min2,and get the new x_min3   
    for i = 1:length(lamda2)
        x_min3(i,1) = lamda2(i,1)*(t_min3-t_min2)+x_min2(i,1);
    end
    x_min3(t_min3_location,:) = [];
else
    x_min3=axis_xt(4);
end

%% plot the figure of RHO2
draw_3d_figures(x_step_size, axis_xt, t_min2, t_step_size, t_min3, lamda2, x_min2, RHO2);
%%  find the new rho of the next part
% Find the new rho of part 3
delete_RHO2_location = t_min3_location + 1;
RHO_new = RHO2;
RHO_new(delete_RHO2_location, :) = [];
RHO3 = RHO_new;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% calculate the values related to next figure/next parts
%% Third part
x_min_o = x_min3;
t_min_o = t_min3;

% get the new RHO
RHO = RHO3;
while length(RHO)>1
    % calculate the new lamda of the new RHO parts;
    lamda=zeros(length(lamda)-1, 1);
    for i=1:length(RHO)-1
        rho1=RHO(i,1);
        rho2=RHO(i+1,1);
        lamda(i,1)=calculate_lamda(rho1, rho2,v_f,rho_max);
    end
    
    % find the new intersection points X_T
    X = zeros(length(lamda)-1, 1);
    T = zeros(length(lamda)-1, 1);
    for i=1:length(lamda)-1
        [X(i,1),T(i,1)] = intersection_point(lamda(i,1),lamda(i+1,1),...
            -lamda(i,1)*t_min_o+x_min_o(i,1),-lamda(i+1,1)*t_min_o+x_min_o(i+1,1)); 
    end
    
    % find the new minimum value of t_min_f and t_min_f_location
    if length(lamda) > 1
        t_min_f = min(T(T > t_min_o));
    
        % find the new location of t_min1
        t_min_f_location = find(abs(T-t_min_f)<delta);
    else
        t_min_f = axis_xt(4);
    
    end
    
    % draw 3-D figures
    draw_3d_figures(x_step_size, axis_xt, t_min_o, t_step_size, t_min_f, lamda, x_min_o, RHO);
    
    % prepare for the next iteration
    for i = 1:length(lamda)
        x_min_f(i,1) = lamda(i,1)*(t_min_f-t_min_o) + x_min_o(i,1);
    end

    x_min_f(t_min_f_location, :) = [];
    x_min_o = x_min_f;
    t_min_o = t_min_f;
    % delete the rho of t_min's location
    delete_RHO = RHO(t_min_f_location+1,1);
    delete_RHO_location = t_min_f_location+1;
    RHO3 = RHO;
    RHO3(delete_RHO_location, :) = [];
    RHO = RHO3;

end

% axis([0 6 0 10]);
view(0,90);

colorbar;