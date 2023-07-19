function Q=calculate_Q(rho,v_f,rho_max,Q_max)
%% initial conditions
    W = rho_max - rho;       
    Q = min([v_f*rho, Q_max, W]);

end

% function Q=calculate_Q(rho,v_f,rho_max,Q_max)
%% initial conditions
% % Q=min(vf*rho,Q_max,W(rho_max-rho));
% % v_f=1; Q_max=1/4; rho_max=1;
% % if 0<rho<1/4, Q=rho;
% % if 1/4<rho<3/4, Q=rho;
% % if 3/4<rho<1, Q=1-rho;
% % if rho>=0 & rho <1/4
% %     Q=rho;
% % elseif rho>= 1/4 & rho<3/4
% %     Q=1/4;
% % elseif rho>=3/4 & rho<=1
% %     Q=1-rho;
% % 
% % end
% 
% 
% %     v_f = 1;
% %     rho_max = 1;
% %     Q_max = 1/4;
%     W = rho_max - rho;       
%     Q = min([v_f*rho, Q_max, W]);
% end