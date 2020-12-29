function least_square_curve_fit(x, y, sigma_values)
%% Cubic Spline
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

if (~exist('x', 'var')) && (~exist('y', 'var'))
    [x, y] = homework_2_values(); 
end

if sigma_values == 1
    fit_type = 'sigma';
    
elseif sigma_values == 0
    fit_type = 'no_sigma';

else
    warning('Unexpected sigma_values type. Input must be a boolean value.')
   
end


switch fit_type
    case 'sigma'
        
        s    = sum(1/sigma^2);
        s_x  = sum(x/sigma^2);
        s_y  = sum(y/sigma^2);
        s_xx = sum(x^2/sigma^2);
        s_xy = sum((x*y)/sigma^2);
        
        delta = ((s * s_xx) - (s_x)^2);
        a_1 = ((s_xx * s_y) - (s_x * s_xy))/delta;
        a_2 = ((s * s_xy) - (s_x * s_y))/delta;
        
        a_1_variance = s_xx/delta;
        a_2_variance = s/delta;
        
    case 'no_sigma'
        
        sigma = 1;
        N = length(x);
        
        s = 1;
        s_x = 1; s_y = 1;
        s_xx = 1; s_xy = 1;
        
        delta = ((s * s_xx) - (s_x)^2);
        a_1 = ((s_xx * s_y) - (s_x * s_xy))/delta;
        a_2 = ((s * s_xy) - (s_x * s_y))/delta;
        
        chi = sum(((y - a_1 - (a_2 * x))/sigma).^2);
        
        a_1_variance = s_xx/delta;
        a_2_variance = s/delta;
        
        a_1_error = a_1_variance * (chi^2/(N - 2)^(1/2));
        a_2_error = a_2_variance * (chi^2/(N - 2)^(1/2));
        
        
    otherwise
        warning('Unexpected fit type. No fit created.')


end

end


function [x, y] = homework_2_values()
rho = [0; 1; 2; 3; 4; 5; 6; 7; 8; 9; 10;];
J_0 = [1.00000; 0.76519; 0.22389; -0.26005; -0.39714; -0.17759; 0.15064; 0.30007; 0.17165; -0.09033; -0.24593];
J_1 = [0.00000; 0.44005; 0.57672; 0.33905; -0.06604; -0.32757; -0.27668; -0.00468; 0.23463; 0.24531; 0.04347;];
J_2 = [0.00000; 0.11490; 0.35283; 0.48690; 0.36412; 0.04656; -0.24287; -0.30141; -0.11299; 0.14484; 0.25463;];
J_1_prime = (J_0 - J_2)/2;
J_1_prime_hardcode = -3:0.5:3;

x = rho;
y = J_1;
end