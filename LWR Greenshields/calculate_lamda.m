% calculate the value of lamda due to rho1 and rho2
function lamda = calculate_lamda(rho1,rho2,rho_max,v_f,n)

    Q_rho1 = calculate_Q(rho1,rho_max,v_f,n);
    Q_rho2 = calculate_Q(rho2,rho_max,v_f,n);

    lamda=(Q_rho1-Q_rho2)/(rho1-rho2);

end

