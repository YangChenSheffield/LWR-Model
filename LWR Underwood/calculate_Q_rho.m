function Q_rho = calculate_Q_rho(rho,v_f,rho_max)
%% LWR Underwood
% Q_rho=v_f*exp(-rho/rho_max)+v_f*rho*exp(-rho/rho_max)(-1/rho_max);
    Q = rho*(v_f*exp(-rho/rho_max));

    delta_rho = 1e-6; % Small change in rho for numerical differentiation
    Q_rho = (Q - (rho-delta_rho)*(v_f*exp(-(rho-delta_rho)/rho_max))) / delta_rho;
end
