function least_square_line_fit(x, y, sigma_bool, sigma_values)
%% Line fit
%   - Curve fit
%   
%   Input Arg
%   ---------
%   x - array: Default: Homework 1 values
%       x-axis values of a table/plot.
%   y - array: Default: Homework 1 values
%       y-axis values of a table/plot
%   spacing - int: Optional argument: Default: 5
%       Number of curve fit plot point between 
%       (x, y) and (x + 1, y + 1).
%
%   Optional Input
%   --------------
%   None
%       Runs func that rutens homework 1 Args
%
%   Output Arg
%   ----------
%   p_x - Curve fit plots
%   x   - Original x-axis values
disp('Running')
disp('-------')
if (~exist('x', 'var')) && (~exist('y', 'var'))
    [x, y, sigma_bool, sigma_values] = homework_2_values(); 
end


if sigma_bool == 1
    fit_type = 'sigma';
    sigma = 0;
    
elseif sigma_bool == 0
    fit_type = 'no_sigma';
    sigma = sigma_values;

else
    warning('Unexpected sigma_values type. Input must be a boolean value.')
end


switch fit_type
    case 'sigma'
        
        s    = sum(1/sigma^2);
        s_x  = sum(x/sigma^2);
        s_y  = sum(y/sigma^2);
        s_xx = sum(x^2/sigma^2);
        s_xy = sum((x * y)/sigma^2);
        
        delta = ((s * s_xx) - (s_x)^2);
        a_1 = ((s_xx * s_y) - (s_x * s_xy))/delta;
        a_2 = ((s * s_xy) - (s_x * s_y))/delta;
        
        a_1_variance = s_xx/delta;
        a_2_variance = s/delta;
        
        fprintf('Error in a_1: %f \n', a_1_variance)
        fprintf('Error in a_2: %f \n', a_2_variance)
        
        
    case 'no_sigma'
        
        n    = length(x);
        s    = sum(1/sigma^2);
        s_x  = sum(x/sigma^2);
        s_y  = sum(y/sigma^2);
        s_xx = sum(x.^2/sigma^2);
        s_xy = sum((x .* y)/sigma^2);
        
        delta = ((s * s_xx) - (s_x)^2);
        a_1   = ((s_xx * s_y) - (s_x * s_xy))/delta;
        a_2   = ((s * s_xy) - (s_x * s_y))/delta;
        
        chi = sum(((y - a_1 - (a_2 * x))/sigma).^2);
        
        a_1_variance = s_xx/delta;
        a_2_variance = s/delta;
        
        a_1_error = a_1_variance * (chi^2/(n - 2)^(1/2));
        a_2_error = a_2_variance * (chi^2/(n - 2)^(1/2));
        
        fprintf('Error in a_1: %f \n', a_1_error)
        fprintf('Error in a_2: %f \n', a_2_error)
        
        
    otherwise
        warning('Unexpected fit type. No fit created.')
        
end

plot_fit(x, y, a_1, a_2)

disp('Done.')

end


function plot_fit(x, y, a_1, a_2)
y_fit = a_2 * x + a_1; 
%f_v = a_1 * y + a_2 * y.^2
disp(['Equation is y = ' num2str(a_2) '*x + ' num2str(a_1)])
hold on
plot(x, y_fit, 'r-')
plot(x, y, 'b.')
legend('Line Fit', 'Velocity Data')

end

function [x, y, sigma_bool, sigma_values] = homework_2_values()

vel_dep_forces = importdata('./vel_dep_forces.dat');
x = vel_dep_forces(:, 1);
y = vel_dep_forces(:, 2);
sigma_bool   = 0;
sigma_values = 1;

end