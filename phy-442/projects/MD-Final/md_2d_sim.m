function md_2d_sim()

%% program options
method = "verlet";
plot_type = 1;
bc        = 1;


% lj_force()
% pause()
n = 289;
n = round(n^(1/2))^2;
n_len = n^(1/2);

fprintf("The number of particles: %d \n", n)
fprintf("The number of particles columns: %d \n", n_len)
fprintf("The number of particles rows:    %d \n", n_len)


spacing    = 2;
box_length = ceil(spacing * n^(1/2));
sigma      = 1.5; 
epsilon    = 0.00001; %1*10^(-10);

m  = 1;   % 0.028; %kg
T  = 300; % K   %tempurature
rc = 10;

% lj_force()
% pause()


%% Time Variables
t0 = 0;
tf = 50;
dt = 0.01;
total_time = t0:dt:tf;
h = (tf - t0)/length(total_time);

%% Initialize Position and Velocity
[x, y, v_x, v_y] = init_variables(spacing, n, box_length, T, m);

%% Initialize Plots
switch plot_type
    case 1
        %fig1 = figure('visible','off');
        fig1 = figure(1);
        plot(x, y, 'o', 'markersize', 5)
    case 2
        figure(1)
        plot(0, 0)
end

time = 0;
while time < length(total_time)
    %% Force Calculation
    a_x = zeros(n, 1);
    a_y = zeros(n, 1);
    for j = 1:n 
       x_i = x(j); 
       y_i = y(j);
       
       [f_x, f_y, v_j] = force_calc(x_i, y_i, x, y, n, epsilon, sigma, rc);
       a_x(j) = f_x/m; % Acceleration x a = F/m
       a_y(j) = f_y/m; % Acceleration y a = F/m
    end
    
  
    %% Numerical Methods (equations of motion)
    dr = zeros(n, 2);
    switch method
        case "euler"
            tic
            for j = 1:(n - 1) % Velocity Euler Algorithm
               x(j) = x(j) + v_x(j) * h + a_x(j) * h^2;
               y(j) = y(j) + v_y(j) * h + a_y(j) * h^2; 
               dr(j, 1) = v_x(j) + a_x(j) * h; 
               dr(j, 2) = v_y(j) + a_y(j) * h; 
            end
            toc

         case "verlet"
            tic
            for j = 1:n % Velocity Verlet Algorithm
               x(j) = x(j) + v_x(j) * h + 1/2 * a_x(j) * h^2;
               y(j) = y(j) + v_y(j) * h + 1/2 * a_y(j) * h^2; 
               dr(j, 1) = v_x(j) * h + 1/2 * a_x(j) * h^2; 
               dr(j, 2) = v_y(j) * h + 1/2 * a_y(j) * h^2; 
            end
            toc
    end
    
    %% Boundry Conditions
    if (bc == 1)
        a_x2 = zeros(n, 1);
        a_y2 = zeros(n, 1);
        xold = x; 
        yold = y;
        for j= 1:n 
           x_i = x(j); 
           y_i = y(j);

           [f_x, f_y, v_j] = force_calc(x_i, y_i, x, y, n, epsilon, sigma, rc);
           a_x2(j) = f_x/m; 
           a_y2(j) = f_y/m;
        end

        for j = 1:n
           v_x(j) = v_x(j) + 1/2 * (a_x(j) + a_x2(j))*h;
           v_y(j) = v_y(j) + 1/2 * (a_y(j) + a_y2(j))*h;

           [xnew, ynew, vxnew, vynew] = boundry_conditions([xold(j), yold(j)], dr(j,:), [v_x(j), v_y(j)], box_length, box_length);
           x(j) = xnew;
           y(j) = ynew;
           v_x(j) = vxnew;
           v_y(j) = vynew;
        end   
    else
        % pass
    end
    
    %% Energy Calculations
    potential_energy = sum(v_j);                          % Potential energy
    kinetic_energy   = 1/2 * m * (v_x(j)^2 + v_y(j)^2);   % Kinetic energy: 1/2mv^2
    total_energy     = potential_energy + kinetic_energy; % Total energy

    %% Plot
    switch plot_type
        case 1
            animate_plot(time, fig1, x, y, n, box_length, total_time)
        case 2
            energy_plot(time, potential_energy, kinetic_energy, total_energy)
    end
   
    
    time = time + dt;
     
     
    
end

end


function [x, y, v_x, v_y] = init_variables(spacing, n, L, T, m)

bk    = 8.31; %J *mol^-1
coord = (spacing/2):spacing:(L-(spacing/2));

[x, y] = meshgrid(coord, coord);
x = x(:);
y = y(:);
x = x(1:n);
y = y(1:n);

% random_num_x = (-1 + 2.*rand(n, 1))/5000;
% v_x = random_num_x * sqrt((2 * bk * T) / (m));
% random_num_y = (-1 + 2.*rand(n, 1))/5000;
% v_y = random_num_y * sqrt((2 * bk * T) / (m));
v_x = -1 + 2.*rand(n, 1);
v_y = -1 + 2.*rand(n, 1);

end


function [f_x, f_y, v_j] = force_calc(x_i, y_i, x, y, n, eps, sigma, rc)
    
    fx_ij = @(r_ij, x_i, x_j, sigma, eps) eps*(12*(sigma/r_ij)^13 - ...
                                          6*(sigma/r_ij)^7)*(x_i - x_j)/r_ij;
    fy_ij = @(r_ij, y_i, y_j, sigma, eps) eps*(12*(sigma/r_ij)^13 - ...
                                          6*(sigma/r_ij)^7)*(y_i - y_j)/r_ij;

    f_x = 0; 
    f_y = 0;
    v_j = 0;
    
    for i = 1:n
        
        x_j = x(i); 
        y_j = y(i);
        
        if x_j == x_i && y_i == y_j
             continue;
        else 
            r_ij = sqrt((x_i - x_j)^2 + (y_i - y_j)^2);
            if r_ij <= rc
                f_x = f_x + fx_ij(r_ij, x_i, x_j, sigma, eps);
                f_y = f_y + fy_ij(r_ij, y_i, y_j, sigma, eps);
                v_j = 4 * eps * ((sigma/r_ij)^12 - (sigma/r_ij)^6);
            elseif r_ij > rc
                continue;
            end
       end
    end
end


function [xnew, ynew, vxnew, vynew] = boundry_conditions(rold, dr, vprev, Nx, Ny)
    x0 = rold(1);
    y0 = rold(2);
    dx = dr(1); 
    dy = dr(2);
    vxnew = vprev(1); vynew = vprev(2);
    xnew = x0+dx;
    ynew = y0+dy;
    if(x0 + dx) > Nx
        diff = x0+dx-Nx;
        xnew = Nx-diff;
        vxnew = -vxnew;
    elseif (x0 + dx) < 0
        xnew = 0+abs(x0+dx);
        vxnew = -vxnew;   
    end
    
    if(y0+dy > Ny)
        diff = y0+dy-Ny;
        ynew = Ny-diff;
        vynew = -vynew;
    elseif(y0+dy < 0)
        ynew = 0+abs(y0+dy);
        vynew = -vynew;   
    end
    

end


function  animate_plot(time, fig1, x, y, n, L, total_time)

    hold on;   
    plot(x, y, 'o','markersize', 5, 'MarkerFaceColor','#ff6969')
    plot(x(round(n/2)), y(round(n/2)), 'bo','markersize', 5, 'MarkerFaceColor','#B4FF91')
    plot(round(L/2), round(L/2), 'mx','markersize', 5)
    title(['2D Molecular Dynamics Simulation Time = ', num2str(time)], 'FontSize', 14);
    xlabel('x', 'FontSize', 12);
    ylabel('y', 'FontSize', 12);
    xlim([0  L])
    ylim([0, L])
    frame = getframe;
    Image = getframe(gcf);
%     
%     if (time == 0.00)
%         imwrite(Image.cdata, ['position_n_', num2str(n), '_t_', num2str(time), '.png']);
%     end
%     
%     if (time == 0.01)
%         imwrite(Image.cdata, ['position_n_', num2str(n), '_t_', num2str(time), '.png']);
%     end
%    
%     if (time == 1.01)
%         imwrite(Image.cdata, ['position_n_', num2str(n), '_t_', num2str(time), '.png']);
%     end
%     
%     if (time == 5.01)
%         imwrite(Image.cdata, ['position_n_', num2str(n), '_t_', num2str(time), '.png']);
%     end
    
    imwrite(Image.cdata, ['position_n_', num2str(n), '_t_', num2str(time), '.png']);
    
    clf(fig1)

end


function energy_plot(time, potential_e, kinetic_e, total_e)
    %fprintf("%f", potential_e)
    figure(1)
    hold on;
    plot(time, potential_e, 'r.')
    plot(time, kinetic_e, 'b.')
    plot(time, total_e, 'g.')
    title('The total energy of the system', 'FontSize', 14);
    xlabel('Time (s)', 'FontSize', 12);
    ylabel('Energy (J)', 'FontSize', 12);
    f = getframe;
    frame = getframe;
    Image = getframe(gcf);
    imwrite(Image.cdata, ['energy_t_', num2str(time), '.png']);

end


function lj_force()

n = 1000;
r       = linspace(0, 17, n);
epsilon = 0.0103;
sigma   = 3.3;

sigma = 1; %radius where the lennard jones potential is 0
epsilon   = 1;

ljp = (48 * epsilon * (sigma^(12))) ./ r.^(13) ...
      - (24 * epsilon * sigma^(6) ./ r.^(7));
  
plot(r, ljp)
title('Lennard-Jones Potential', 'FontSize', 14);
xlabel('r(\sigma) (Å)', 'FontSize', 12);
ylabel('Potential Energy (J)', 'FontSize', 12);
yline(0, '--r')
xlim([0  8])
ylim([0, 0.9])

end
