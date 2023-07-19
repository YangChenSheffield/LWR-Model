function Q=calculate_Q(rho,v_0,rho_max)
%% LWR Greenberg
%  Q(rho)=rho*V;
%       =rho*(v_0*log(rho_max/rho));    
    Q = v_0*rho*log(rho_max/rho);
end
