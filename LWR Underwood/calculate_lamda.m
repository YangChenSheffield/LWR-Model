function lamda = calculate_lamda(rho1,rho2,v_f,rho_max)
%% LWR Underwood
    Q1=calculate_Q(rho1,v_f,rho_max);
    Q2=calculate_Q(rho2,v_f,rho_max);

    lamda=(Q1-Q2)/(rho1-rho2);
    
end

