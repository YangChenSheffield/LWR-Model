function Q_rho_dot = calculate_Q_rho_dot_Greenshields(rho,rho_max,v_f,n)

    Q_rho_dot = - v_f*((rho/rho_max)^n - 1) - (n*rho*v_f*(rho/rho_max)^(n - 1))/rho_max ;

end

