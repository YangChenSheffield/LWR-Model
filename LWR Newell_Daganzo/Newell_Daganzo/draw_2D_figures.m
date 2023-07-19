%% draw 2-D figures
function draw_2D_figures(lamda1, t_min1, t_min2, x_min1, t_step_size)
    for i = 1:length(lamda1)
        t = t_min1:t_step_size:t_min2;
        x = lamda1(i,1)*(t-t_min1) + x_min1(i,1);
        plot(x, t);
        hold on;
        grid on;
    end
end
