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
delta=0.00001;
Q_Greenshields_rho=- v_f.*((rho./rho_max).^n - 1) - (n.*rho.*v_f.*(rho./rho_max).^(n - 1))./rho_max ;

% figure;
% plot(rho,V_Greenshields);
% plot(rho,Q);
% figure;
% plot(rho,Q_Greenshields_rho);

%% Newell-Daganzo
rho=0:0.001:1;
Q_max=0.25;
for i=1:length(rho)
    W(1,i) = rho_max - rho(1,i);
    Q_ND(1,i) = min([v_f*rho(1,i), Q_max, W(1,i)]);
end

delta_rho = 1e-6; % Small change in rho for numerical differentiation
for i=1:length(rho)
    Q_ND_rho(1,i) = (Q_ND(1,i) - min([v_f * (rho(1,i) - delta_rho), Q_max, rho_max - (rho(1,i) - delta_rho)])) / delta_rho;
end

for i=1:length(rho)
    V_ND(1,i)=Q_ND(1,i)./rho(1,i);
end
% figure;
% plot(rho,Q_ND);
% figure;
% plot(rho,Q_ND_rho);

%% Greenberg
v_0=1;
rho=0:0.001:1;
V_Greenberg=v_0.*log(rho_max./rho);
Q_Greenberg=rho.*V_Greenberg;
delta_rho = 1e-6; % Small change in rho for numerical differentiation
Q_Greenberg_rho = (Q_Greenberg - v_0.*(rho-delta_rho).*log(rho_max./(rho-delta_rho))) ./ delta_rho;
% figure;
% plot(rho,V_Greenberg);
% plot(rho,Q_Greenberg);
% figure;
% plot(rho,Q_Greenberg_rho);


%% Underwood
rho=0:0.001:1;
V_Underwood=v_f.*exp(-rho./rho_max);
Q_Underwood=rho.*V_Underwood;
delta_rho = 1e-6; % Small change in rho for numerical differentiation
Q_Underwood_rho = (Q_Underwood - (rho-delta_rho).*(v_f.*exp(-(rho-delta_rho)./rho_max))) ./ delta_rho;
% figure;
% plot(rho,V_Underwood);
% plot(rho,Q_Underwood);
% figure;
% plot(rho,Q_Underwood_rho);

%% California model
rho=0:0.001:1;
V_California=v_0.*(1./rho-1/rho_max);
Q_California=rho.*V_California;
delta_rho = 1e-6; % Small change in rho for numerical differentiation
Q_California_rho = (Q_California - (rho-delta_rho).*v_0.*(1./(rho-delta_rho)-1/rho_max)) ./ delta_rho;
% figure;
% plot(rho,V_California);
% plot(rho,Q_California);
% figure;
% plot(rho,Q_California_rho);

figure;
plot(rho,V_Greenshields);
hold on;
grid on;
plot(rho,V_ND);
hold on;
grid on;
plot(rho,V_Greenberg);
hold on;
grid on;
plot(rho,V_Underwood);
hold on;
grid on;

legend('Greenshields','Newell-Daganzo','Greenberg','Underwood');
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
xlabel('\rho','FontSize', 14);
ylabel('Q(\rho)','FontSize', 14);

figure;
plot(rho,Q_Greenshields_rho);
hold on;
grid on;
plot(rho,Q_ND_rho);
hold on;
grid on;
plot(rho,Q_Greenberg_rho);
hold on;
grid on;
plot(rho,Q_Underwood_rho);
hold on;
grid on;
plot(rho,Q_California_rho);
legend('Greenshields','Newell-Daganzo','Greenberg','Underwood','California');
xlabel('\rho','FontSize', 14);
ylabel('Q_{\rho}','FontSize', 14);
