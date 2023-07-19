function Q_rho = calculate_Q_rho(rho,v_0,rho_max)
%% LWR California model
% Q_rho=v_0*(1/rho - 1/rho_max) - v_0/rho
%      =-v_0/rho_max;

    Q = rho*v_0*(1/rho-1/rho_max);

    delta_rho = 1e-6; % Small change in rho for numerical differentiation
    Q_rho = (Q - (rho-delta_rho)*v_0*(1/(rho-delta_rho)-1/rho_max)) / delta_rho;
end
