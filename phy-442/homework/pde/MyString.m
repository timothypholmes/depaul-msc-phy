function MyString(c, x, x_length, u, u0, du0, N, maxtime, hx, dt)


    epsilon = (dt * c/hx); % Needs to remain < 1 to insure stability 
    % if epsilon > 1 % Courant number
    %     disp(epsilon)
    %     error('epsilon too large, PDE will be unstable')
    % end

    %% Preallocate
    %u  = zeros(1, N);
    %u  = zeros(1, N);
    %u0 = zeros(1, N);

    u_old = u0;
    u_new = zeros(1, N);
    time  = 0.0;  % Init time (t0)

    for i = 2:(N - 1)
        u(i) = 0.5 * epsilon * (u0(i + 1) + u0(i - 1)) + ... 
               (1.0 - epsilon) * u0(i) + dt * du0(i); 
    end 
    


    %% Start main time loop 
    tdisp = 0;
    fig = figure;

    while time < maxtime 
        if ~ishghandle(fig)
            break
        end

        time  = time + dt;
        tdisp = tdisp + 1;
        

        for i = 2:(N - 1) 
            u_new(i) = epsilon * (u(i + 1) + u(i - 1)) + ... 
                      2.d0 * (1.0 - epsilon) * u(i) - u_old(i);
        end 
      

        u_old = u; 
        u     = u_new; 
        
        % Problem 5
        u(1) = u(2);
        u(N) = u(N - 1);

        %% plot
        pause(0.01)
        pause
        plot(x, u, 'r');
        axis([0 x_length -1 1]);
        title(["Time", tdisp])
        xlabel("x")
        ylabel("u(x)")

    end
    close(fig);

end
