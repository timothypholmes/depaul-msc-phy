function general_non_linear_least_squares(x, y)
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

N = length(x);
h = 0.04;

for k = 1:N
    chi_sq = 1;
end



dy = zeros(N,1); % preallocate derivative vectors
ddy = zeros(N,1);
for i=2:(N - 1)
    dy(i) = (y(i - 1) + y(i + 1))/2/h;
    ddy(i) = (y(i + 1) - 2 * y(i) + y(i - 1))/h^2;
end




end

function [x, y] = homework_2_values()

gaussian = importdata('./gaussian.dat');
x = gaussian(:, 1);
y = gaussian(:, 2);

%f_x = @(x) A * exp(-((x - mu)^2)/(2 * sigma^2))

end
