function Q=calculate_Q(rho,v_0,rho_max)
%% LWR California model
    Q = rho*v_0*(1/rho-1/rho_max);
end
