function Q_rho = calculate_Q_rho(rho,v_0,rho_max)
%% LWR Greenberg
% Q_rho=v_0*log(rho_max/rho)+v_0*rho*rho;
    Q = v_0*rho*log(rho_max/rho);

    delta_rho = 1e-6; % Small change in rho for numerical differentiation
    Q_rho = (Q - v_0*(rho-delta_rho)*log(rho_max/(rho-delta_rho))) / delta_rho;
end
