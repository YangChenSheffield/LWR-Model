function [lamda2] = calculate_lamda2_values(RHO2,rho_max,v_f,n)
    % Calculate lamda2
    for i = 1:length(RHO2)-1
        lamda2(i,1) = calculate_lamda(RHO2(i,1), RHO2(i+1,1),rho_max,v_f,n);
    end
end
