clear all;
clc;
close all;

%% Greenshields
v_f=1;
n=1;
rho_max=1;
rho=0:0.001:1;
V_Greenshields=v_f*(1-(rho/rho_max).^n);
Q_Greenshields=rho.*V_Greenshields;

% figure;
% plot(rho,V_Greenshields);
% plot(rho,Q);

%% Newell-Daganzo
rho=0:0.001:1;
Q_max=0.25;
for i=1:length(rho)
    W(1,i) = rho_max - rho(1,i);
    Q_ND(1,i) = min([v_f*rho(1,i), Q_max, W(1,i)]);
end
% figure;
% plot(rho,Q_ND);

%% Greenberg
v_0=1;
rho=0:0.001:1;
V_Greenberg=v_0.*log(rho_max./rho);
Q_Greenberg=rho.*V_Greenberg;
% figure;
% plot(rho,V_Greenberg);
% plot(rho,Q_Greenberg);

%% Underwood
rho=0:0.001:1;
V_Underwood=v_f.*exp(-rho./rho_max);
Q_Underwood=rho.*V_Underwood;
% figure;
% plot(rho,V_Underwood);
% plot(rho,Q_Underwood);

%% California model
rho=0:0.001:1;
V_California=v_0.*(1./rho-1/rho_max);
Q_California=rho.*V_California;
% figure;
% plot(rho,V_California);
% plot(rho,Q_California);

figure;
plot(rho,V_Greenshields);
hold on;
grid on;
plot(rho,V_Greenberg);
hold on;
grid on;
plot(rho,V_Underwood);
hold on;
grid on;
% plot(rho,V_California);
legend('Greenshields','Greenberg','Underwood');
xlabel('\rho','FontSize', 14);
ylabel('V(\rho)','FontSize', 14);

figure;
plot(rho,Q_Greenshields);
hold on;
grid on;
plot(rho,Q_ND);
hold on;
grid on;
plot(rho,Q_Greenberg);
hold on;
grid on;
plot(rho,Q_Underwood);
hold on;
grid on;
plot(rho,Q_California);
legend('Greenshields','Newell-Daganzo','Greenberg','Underwood','California');





