clear all;
clc;
close all;

% % Professor First condition
axis_xt = [0 6 0 10 0 1];
RHO_0 = [0.1, 1, 0.2, 0.4, 0.7, 0.9]';
X0_0 = [1, 2, 3, 4, 5]';

delta=0.001;

% % [DelleMonache2018] Fig.6
% axis_xt = [-5 15 0 120 0 1];
% RHO_0 = [.3125 .5 .8125 .5]';
% X0_0 = [-1 4 10]';

% % [DelleMonache2018] Fig.5
% axis_xt = [0 20 0 40 0 1];
% RHO_0 = [.0938 .9688 .25 .4375 .7812 .9688]';
% X0_0 = [2.1 10.1 12 16 19]';

% [DelleMonache2018] Fig.4
% axis_xt = [0 16 0 20 0 1];
% RHO_0 = [.0938 .9062 .2188 .9062]';
% X0_0 = [8 10 13]';

%% t_step_size Set step size for t
t_step_size = 0.0001;

%% x_step_size Set step size for x
x_step_size = 0.01;

%% initial conditions
rho_max=1;
v_f=1;
n=1;

%% lamda1, insert_RHO1_location, rho_wave2, lamda_wave2
% calculate the values of lamda1 of the first part 
insert_RHO1_location = [];
rho_wave2 = [];
lamda_wave2 = [];
k = 1;
lamda1 = [];
for i = 1:length(RHO_0)-1

    % rarefaction wave 1
    rho_max=1;
    v_f=1;
    n=1;
    Q_rho1_dot=calculate_Q_rho_dot_Greenshields(RHO_0(i),rho_max,v_f,n);
    Q_rho2_dot=calculate_Q_rho_dot_Greenshields(RHO_0(i+1),rho_max,v_f,n);

    if Q_rho1_dot > Q_rho2_dot
        rho_max=1;
        v_f=1;
        n=1;
        lamda1(i,1) = calculate_lamda(RHO_0(i), RHO_0(i+1),rho_max,v_f,n);

    elseif Q_rho1_dot < Q_rho2_dot
        insert_RHO1_location(k,1) = i;
        rho_0 = min(RHO_0(i), RHO_0(i+1));
        rho_n = max(RHO_0(i), RHO_0(i+1));
        no = ceil((rho_n - rho_0) * 32);
        rho_wave2(1,k) = rho_0;

        for j = 1:no
            rho_wave2(j+1,k) = rho_0 + (1/32)*j;
            if rho_wave2(j+1,k) > rho_n
                rho_wave2(j+1,k) = rho_n;
            else
                rho_wave2(j+1,k) = rho_wave2(j+1,k);
            end
            rho_max=1;
            v_f=1;
            n=1;
            lamda_wave2(j,k) = calculate_lamda(rho_wave2(j,k), rho_wave2(j+1,k),rho_max,v_f,n);
        end

        k = k + 1;
        lamda1(i,1) = 0;
    end
end


%% lamda1

if isempty(insert_RHO1_location)

    insert_RHO1_location=[];
else
    % find intersection lines' lamda and x0 — lamda1
    A = lamda1;
    % Insert its value into rows k1 and k2 of A respectively
    k = insert_RHO1_location';
    A1=A(1:k-1);
    A2=A(k+1:end);
    D=[A1;flipud(lamda_wave2(:,1));A2];
    lamda1 = D;
end


%% x_min1
% x_min1 = insert_x_min1(insert_RHO1_location, X0_0, lamda_wave2);
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
    A2 = A(k(i):end);
    B = X0_0(insert_RHO1_location(i,1),1) * ones(length(lamda_wave2(:,i))-1, 1);
    C = [A1; B; A2];

    % Assign the new matrix C back to the original matrix A
    A = C;
    if i+1 <= length(k)
        k(i+1,1) = g(i+1,1) + length(B)+1;
    end
end

x_min1 = A;

%% if length(RHO_0)==2
if length(RHO_0) == 2
    t_min1=0;
    t_min2=axis_xt(4);
    RHO1=flipud(rho_wave2);
    %% draw 3-D figures when there are only two values of rho
    % draw_3d_figures(x_step_size, axis_xt, t_min1, t_step_size, t_min2, lamda1, x_min1, RHO1);
    [X1, T1] = meshgrid(axis_xt(1):x_step_size:axis_xt(2), t_min1:t_step_size:t_min2);
    [M, N] = size(X1);
    Z1 = zeros(M, N);
    
    for i = 1:M
        for j = 1:N
            if X1(i, j) >= lamda1(length(lamda1), 1) * (T1(i, j) - t_min1) + x_min1(length(lamda1), 1)
                Z1(i, j) = RHO1(length(lamda1) + 1, 1);
            elseif X1(i, j) < lamda1(1, 1) * (T1(i, j) - t_min1) + x_min1(1, 1)
                Z1(i, j) = RHO1(1, 1);
            else
                for k = 1:length(lamda1) - 1
                    if X1(i, j) >= lamda1(k, 1) * (T1(i, j) - t_min1) + x_min1(k, 1) && ...
                            X1(i, j) < lamda1(k + 1, 1) * (T1(i, j) - t_min1) + x_min1(k + 1, 1)
                        Z1(i, j) = RHO1(k + 1, 1);
                    end
                end
            end
        end
    end
    
    s = surf(X1, T1, Z1);
    xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('$t$', 'Interpreter', 'latex', 'FontSize', 20);
    s.EdgeColor = 'none';
    hold on;
    grid on;
end


if length(RHO_0) == 2 
    view(0,90);
    error('Finish figure');
end



%% RHO1
%% RHO1
% RHO1 = insert_RHO_0(RHO_0, insert_RHO1_location, rho_wave2);
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
    B = rho_wave2(:,i);
    B = flipud(B);
    C = [A1; B; A2];

    % Assign the new matrix C back to the original matrix A
    A = C;
    if i+1 <= length(k)
        k(i+1,1) = g(i+1,1) + length(B) - 2;
    end
end
RHO1=A;
%% t_min1 
t_min1 = 0;

%% find the values of t_min2, delete_RHO1, x_min2,t_min2_location
% Find intersection points
X=[];
T=[];
for i = 1:length(lamda1)-1
    [X(i,1),T(i,1)] = intersection_point(lamda1(i,1), lamda1(i+1,1), -lamda1(i,1)*t_min1+x_min1(i,1), -lamda1(i+1,1)*t_min1+x_min1(i+1,1));
end

% Find the minimum value of t
t_min2 = min(T(T>t_min1));

idx=0;

for i=1:length(T)
    if abs(t_min2-T(i,1))<0.000000001
        idx=idx+1;
    end
end

% Find the location of t_min1
t_min2_location = find(abs(T-t_min2)<delta);

if idx>1
    for i=1:idx
        t_location(i,1) = t_min2_location(i,1)+i-1;
    end

else
    t_location = t_min2_location;
end

t_min2_location = t_location;


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
% [RHO2] = find_new_rho_of_new_part(RHO1, t_min2_location);
delete_RHO1_location = t_min2_location + 1;
RHO_new = RHO1;
RHO_new(delete_RHO1_location, :) = [];
RHO2 = RHO_new;


%% draw 3-D figures of part 1
% draw_3d_figures(x_step_size, axis_xt, t_min1, t_step_size, t_min2, lamda1, x_min1, RHO1);
[X1, T1] = meshgrid(axis_xt(1):x_step_size:axis_xt(2), t_min1:t_step_size:t_min2);
[M, N] = size(X1);
Z1 = zeros(M, N);

for i = 1:M
    for j = 1:N
        if X1(i, j) >= lamda1(length(lamda1), 1) * (T1(i, j) - t_min1) + x_min1(length(lamda1), 1)
            Z1(i, j) = RHO1(length(lamda1) + 1, 1);
        elseif X1(i, j) < lamda1(1, 1) * (T1(i, j) - t_min1) + x_min1(1, 1)
            Z1(i, j) = RHO1(1, 1);
        else
            for k = 1:length(lamda1) - 1
                if X1(i, j) >= lamda1(k, 1) * (T1(i, j) - t_min1) + x_min1(k, 1) && ...
                        X1(i, j) < lamda1(k + 1, 1) * (T1(i, j) - t_min1) + x_min1(k + 1, 1)
                    Z1(i, j) = RHO1(k + 1, 1);
                end
            end
        end
    end
end

s = surf(X1, T1, Z1);
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 20);
ylabel('$t$', 'Interpreter', 'latex', 'FontSize', 20);
s.EdgeColor = 'none';
hold on;
grid on;

%% Second part
%% % calculate the lamda of the second part;
% Calculate lamda2
rho_max=1;
v_f=1;
n=1;
for i = 1:length(RHO2)-1
    lamda2(i,1) = calculate_lamda(RHO2(i,1), RHO2(i+1,1),rho_max,v_f,n);
end

%% % calculate the values of t_min3, delete_RHO2, x_min3,t_min3_location
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



%% % find the new rho of part 3
% [RHO3] = find_new_rho_of_new_part(RHO2, t_min3_location);
% Find the new rho of part 2
if length(RHO2)>2
    delete_RHO2_location = t_min3_location + 1;
    RHO_new = RHO2;
    RHO_new(delete_RHO2_location, :) = [];
    RHO3 = RHO_new;
end

%% % draw 3-D figures of part 2
% draw_3d_figures(x_step_size, axis_xt, t_min2, t_step_size, t_min3, lamda2, x_min2, RHO2);
[X1, T1] = meshgrid(axis_xt(1):x_step_size:axis_xt(2), t_min2:t_step_size:t_min3);
[M, N] = size(X1);
Z1 = zeros(M, N);

for i = 1:M
    for j = 1:N
        if X1(i, j) >= lamda2(length(lamda2), 1) * (T1(i, j) - t_min2) + x_min2(length(lamda2), 1)
            Z1(i, j) = RHO2(length(lamda2) + 1, 1);
        elseif X1(i, j) < lamda2(1, 1) * (T1(i, j) - t_min2) + x_min2(1, 1)
            Z1(i, j) = RHO2(1, 1);
        else
            for k = 1:length(lamda2) - 1
                if X1(i, j) >= lamda2(k, 1) * (T1(i, j) - t_min2) + x_min2(k, 1) && ...
                        X1(i, j) < lamda2(k + 1, 1) * (T1(i, j) - t_min2) + x_min2(k + 1, 1)
                    Z1(i, j) = RHO2(k + 1, 1);
                end
            end
        end
    end
end

s = surf(X1, T1, Z1);
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 20);
ylabel('$t$', 'Interpreter', 'latex', 'FontSize', 20);
s.EdgeColor = 'none';
hold on;
grid on;

% if length(RHO3)==1
%     view(0,90);
%     error('Finish figure');
% end

if length(RHO2)<3
    RHO3=[];
end

%% Next Parts
if length(RHO3)>1
    x_min_o = x_min3;
    t_min_o = t_min3;
    
    % get the new RHO
    RHO = RHO3;
    
    while length(RHO) > 1
        % calculate the new lamda of the new RHO parts;
        rho_max=1;
        v_f=1;
        n=1;
        lamda = calculate_lamda2_values(RHO,rho_max,v_f,n);
    
        % find the new intersection points X_T
        % [X, T] = calculate_XT(lamda, t_min_o, x_min_o);
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
        % draw_3d_figures(x_step_size, axis_xt, t_min_o, t_step_size, t_min_f, lamda, x_min_o, RHO);
        [X1, T1] = meshgrid(axis_xt(1):x_step_size:axis_xt(2), t_min_o:t_step_size:t_min_f);
        [M, N] = size(X1);
        Z1 = zeros(M, N);
    
        for i = 1:M
            for j = 1:N
                if X1(i, j) >= lamda(length(lamda), 1) * (T1(i, j) - t_min_o) + x_min_o(length(lamda), 1)
                    Z1(i, j) = RHO(length(lamda) + 1, 1);
                elseif X1(i, j) < lamda(1, 1) * (T1(i, j) - t_min_o) + x_min_o(1, 1)
                    Z1(i, j) = RHO(1, 1);
                else
                    for k = 1:length(lamda) - 1
                        if X1(i, j) >= lamda(k, 1) * (T1(i, j) - t_min_o) + x_min_o(k, 1) && ...
                                X1(i, j) < lamda(k + 1, 1) * (T1(i, j) - t_min_o) + x_min_o(k + 1, 1)
                            Z1(i, j) = RHO(k + 1, 1);
                        end
                    end
                end
            end
        end
    
        s = surf(X1, T1, Z1);
        xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 20);
        ylabel('$t$', 'Interpreter', 'latex', 'FontSize', 20);
        s.EdgeColor = 'none';
        hold on;
        grid on;
    
        % prepare for the next iteration
        % [x_min_o, t_min_o, RHO] = update_parameters(lamda, t_min_f, t_min_o, x_min_o, t_min_f_location, RHO);
        for i = 1:length(lamda)
            x_min_f(i,1) = lamda(i,1)*(t_min_f-t_min_o) + x_min_o(i,1);
        end
        x_min_f(t_min_f_location, :) = [];
        x_min_o = x_min_f;
        t_min_o = t_min_f;
        % delete the rho of t_min's location
        delete_RHO = RHO(t_min_f_location+1,1);
        delete_RHO_location = [];
        if length(delete_RHO) > 1
            delete_RHO_location(1,1) = find(RHO == delete_RHO(1,1));
            for n = 2:length(delete_RHO)
                delete_RHO_location(n,1) = delete_RHO_location(n-1,1) + 1;
            end
        else
            delete_RHO_location = find(RHO == delete_RHO);
        end
        RHO3 = RHO;
        RHO3(delete_RHO_location, :) = [];
        RHO = RHO3;
    
    end
end
axis_xt = [0 3 0 5 0 1];
view(0,90);
colorbar;