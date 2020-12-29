function monte_carlo_average(g_x, a, b, n_regions, n)
%% Monte Carlo Average
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
%   n_regions - int: Default: data
%       Number of split regions
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
if (~exist('g_x', 'var')) && (~exist('a', 'var')) && (~exist('b', 'var')) && (~exist('n_regions', 'var')) && (~exist('n', 'var'))
    [g_x, a, b, n_regions, n] = sample_data(); 
end

region_split = n_regions;
regions = linspace(a, b, (region_split + 1));
m = (length(regions) - 1);

region_length = zeros((length(regions) - 1), 1);
for i = 1:m
    region_length(i) = regions(i + 1) - regions(i);
end

func    = zeros(n, 1);
area    = zeros(m, 1);
func_sq = zeros(n, 1);
error   = zeros(n, 1);
x_line = linspace(a, b, 1000);

fig1 = figure('Visible', 'off');
ax1 = axes('Parent', fig1);
hold(ax1, 'on');
p2 = zeros(m, 1);
legend_info = cell(m, 1);

for i = 1:m
    for j = 1:n
    
    x = regions(i) + (regions(i + 1) - regions(i)) .* rand(j, 1);
    
    func(j) = g_x(x(j));
    func_sq(j) = g_x(x(j))^2;
    
    plot(x(j), func(j))

    end
    
    func_avg = sum(func)/n;
    func_sq_avg = sum(func_sq)/n;
    
    area(i) = func_avg * region_length(i);
  
    error(i) = region_length(i) * sqrt((func_sq_avg - func_avg^2)/n);
    

    plot(ax1, x_line, g_x(x_line), 'r');
    p2(i) = plot(ax1, x, func, '.');
    legend_info{i} = ['Region Cluster: ', num2str(i)]; 
    
end

total_area = sum(area);
fprintf('Total area: %f \n', total_area)

total_error = sum(error);
fprintf('Total error: %f \n', total_error)

%% generate plot
title({['Monte Carlo Average of ', func2str(g_x)]; ['Area: ', num2str(total_area), ', Error: \pm', ...
        num2str(total_error), ', N Points: ', num2str(n), ', N Regions: ', num2str(n_regions)]})
legend(p2(:), legend_info{:})
hold(ax1, 'off');
set(fig1, 'Visible', 'on');
end



function [g_x, a, b, n_regions, n] = sample_data()

% g_x = @(x) (4./(1 + x.^2));
% a = 0; %x_lower_bound
% b = 1;  %x_upper_bound
% n = 10000;
% n_regions = 1;

g_x = @(x) (4 * sqrt(1 - x.^2));
a = 0; %x_lower_bound
b = 1;  %x_upper_bound
n = 1000;
n_regions = 1;

end