
function Q_rho = calculate_Q_rho(rho,v_f,rho_max,Q_max)
    W = rho_max - rho;
    Q = min([v_f * rho, Q_max, W]);

    delta_rho = 1e-6; % Small change in rho for numerical differentiation
    Q_rho = (Q - min([v_f * (rho - delta_rho), Q_max, rho_max - (rho - delta_rho)])) / delta_rho;
end








% function Q_rho = calculate_Q_rho(rho,v_f,rho_max,Q_max)
% 
% % %     v_f = 1;
% % %     rho_max = 1;
% % %     Q_max = 1/4;
% %     
% %     % 定义函数 W
% %     W = rho_max-rho;
% %     
% %     if rho>=0 & rho<Q_max/v_f
% %         Q_rho=v_f;
% %     elseif rho>=Q_max/v_f & rho<rho_max-Q_max
% %         Q_rho=0;
% %     elseif rho>=rho_max-Q_max & rho<=1
% %         Q_rho=-1;
% %     end
% 
% 
% syms rho rho_max v_f Q_max W
% W = rho_max - rho;
% Q = min([v_f*rho, Q_max, W]);
% 
% dQ_drho = diff(Q, rho);
% 
% 
% end



