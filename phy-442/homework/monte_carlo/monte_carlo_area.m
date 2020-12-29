function monte_carlo_area(g_x, a, b, c, d, n)
%% Cubic Spline
%   - Curve fit
%   
%   Input Arg
%   ---------
%   g_x - function: Default: data
%       Some function
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
%       Runs func that rutens homework 1 Args
%
%   Output Arg
%   ----------
%   p_x - Curve fit plots
%   x   - Original x-axis values
disp('Running')
disp('-------')
if (~exist('g_x', 'var')) && (~exist('a', 'var')) && (~exist('b', 'var')) && (~exist('c', 'var')) && (~exist('d', 'var')) && (~exist('n', 'var'))
    [g_x, a, b, c, d, n] = sample_data(); 
end
x = linspace(a, b, n);
original_function = g_x(x);

hold on
plot(x, original_function, 'k')
xlim([a b])
ylim([c d])

width  = (b - a);
height = (d - c);

count = 0;

for i = 1:n
    x = a + (b - a) .* rand(i, 1);
    y = c + (d - c) .* rand(i, 1);
    
    func = g_x(x(i));
    
    if (y(i) <= func)

        plot(x(i), y(i), '.g')
        count = count + 1;
    else 
        plot(x(i), y(i), '.r')
    end
end

area = (count/n) * (width * height);
hold on
title(['Estimate Area: ', num2str(area)], 'Color','blue');
fprintf('Integral Estimate: %f\n', area)

end

function [g_x, a, b, c, d, n] = sample_data()

%g_x = @(x) (3 * x.^2);
g_x = @(x) (sin(x));
%g_x = @(x) (x.^2);
a = -2; %x_lower_bound
b = 2;  %x_upper_bound
c = -2; %y_lower_bound
d = 2;  %y_upper_bound
n = 1000;

end