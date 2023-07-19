%% draw 3-D figures
function draw_3d_figures(x_step_size, axis_xt, t_min1, t_step_size, t_min2, lamda1, x_min1, PHO1)
    % x=lamda*(t-t0)+x0;
    [X1, T1] = meshgrid(axis_xt(1):x_step_size:axis_xt(2), t_min1:t_step_size:t_min2);
    [M, N] = size(X1);
    Z1 = zeros(M, N);

    for i = 1:M
        for j = 1:N
            if X1(i, j) >= lamda1(length(lamda1), 1) * (T1(i, j) - t_min1) + x_min1(length(lamda1), 1)
                Z1(i, j) = PHO1(length(lamda1) + 1, 1);
            elseif X1(i, j) < lamda1(1, 1) * (T1(i, j) - t_min1) + x_min1(1, 1)
                Z1(i, j) = PHO1(1, 1);
            else
                for k = 1:length(lamda1) - 1
                    if X1(i, j) >= lamda1(k, 1) * (T1(i, j) - t_min1) + x_min1(k, 1) && ...
                            X1(i, j) < lamda1(k + 1, 1) * (T1(i, j) - t_min1) + x_min1(k + 1, 1)
                        Z1(i, j) = PHO1(k + 1, 1);
                    end
                end
            end
        end
    end

    s = surf(X1, T1, Z1);
    xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 20);
    ylabel('$t$', 'Interpreter', 'latex', 'FontSize', 20);
    s.EdgeColor = 'none';
    hold on;
    grid on;
end

