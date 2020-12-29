function mid_point_euler_method(t0, tf, y0, h, func)
%% Euler Midpoint Method
%   - Curve fit
%   
%   Input Arg
%   ---------
%   t0 - function: Default: data
%       Some function
%   tf - float: Default: data
%       x_lower_bound
%   y0 - float: Default: data
%       x_upper_bound
%   h - float: Default: data
%       y_lower_bound
%   func - float: Default: data
%       y_upper_bound
%
disp('Running')
disp('-------')
if (~exist('t0', 'var')) && (~exist('tf', 'var')) && (~exist('y0', 'var')) && (~exist('h', 'var')) && (~exist('func', 'var'))
    [t0, tf, y0, h, func] = sample_data();
end
t    = t0:h:tf;        % the range of x
y    = zeros(size(t)); % allocate the result y
y(1) = y0;             % the initial y value

for i = 2:length(t)
  y(i) = y(i - 1) + h * func(t(i - 1) + h/2, y(i - 1) + (h/2) * func(t(i - 1), y(i - 1)));
end

figure(1)
hold on
plot(t, y, ':ro')

end

function [t0, tf, y0, h, func] = sample_data()

h    = 0.05;
y0   = 3;
t0   = 0;
tf   = 5;
func = @(t, y) exp(t) .* sin(y);

end