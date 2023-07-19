function Q=calculate_Q(rho,v_f,rho_max)
%% LWR Underwood 
    Q = rho*(v_f*exp(-rho/rho_max));
end
