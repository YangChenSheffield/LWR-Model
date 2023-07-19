function Q_rho = calculate_Q(rho,rho_max,v_f,n)

        Q_rho = -rho*v_f*((rho/rho_max)^n - 1);
        
end

