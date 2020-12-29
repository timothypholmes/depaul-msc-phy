function monte_carlo_simulation(particles, num_colisions)
%% Cubic Spline
%   - Curve fit
%   
%   Input Arg
%   ---------
%   g_x - funum_colisionstion: Default: data
%       Some funum_colisionstion
%   a - float: Default: data
%       x_lower_bound
%   b - float: Default: data
%       x_upper_bound
%   c - float: Default: data
%       y_lower_bound
%   d - float: Default: data
%       y_upper_bound
%   n - int: 
%       Number of random points
%
%   Optional Input
%   --------------
%   None
%       Runs funum_colisions that rutens homework 1 Args
%
%   Output Arg
%   ----------
%   p_x - Curve fit plots
%   x   - Original x-axis values
disp('Running')
disp('-------')
if (~exist('N', 'var')) && (~exist('p', 'var')) 
    [particles, num_colisions] = sample_data(); 
end

count = 0;
r = 1;
lambda = 1;
dis = zeros(particles, num_colisions);
for i = 1:particles
    x1 = 5;
    y1 = 5;
    z1 = 5;
    count = count + 1;
    for j = 1:num_colisions
  
        theta = acos(-1 + 2*rand);
        %q = cos(theta);
        phi = 2 * pi * rand;
        [x, y, z] = sph2cart(theta, phi, r);
        x1 = x + x1;
        y1 = y + y1;
        z1 = z + z1;
        dis(i, j) = sqrt((x1 - 5)^2 + (y1 - 5)^2 + (z1 - 5)^2);
        if count == num_colisions
            %scatter3(x1, y1, z1, 'MarkerFaceColor', 'k')
            %hold on
        end
    end
end

%% Set equations for figure 1
N = linspace(0, num_colisions, length(dis));
N_q_approx = mean(dis)/lambda;
%dis_approx = N.^q;

%% Plot figure 1
hold on
figure(1)
plot(N, N_q_approx)
xlabel('Number of collisions (N)')
ylabel('<d>/\lambda')

%fprintf("Number of collisions: %f \n", N(end0)
%fprintf("<d>/\lambda: %f \n", N_q_approx)

%% Set equations for figure 1
q_ln_N_approx = log(mean(dis)/lambda);
ln_N = log(N);
ln_N(1) = 0;

%% Plot figure 2
hold on
figure(2)
least_square_line_fit(ln_N, q_ln_N_approx, 0, 1)

c = polyfit(ln_N, q_ln_N_approx, 1);
disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))])
yfit = c(1) * ln_N + c(2);
plot(ln_N, yfit)
xlabel('log(N)')
ylabel('log(<d>)/\lambda')


end


function [particles, num_colisions] = sample_data()

particles =  100;
num_colisions = 100;

end