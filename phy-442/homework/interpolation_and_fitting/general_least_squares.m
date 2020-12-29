function [a, b] = general_least_squares(x_i, y_i, sigma_i)
%% general least squares
%   - Curve fit
%   


if (~exist('x_i', 'var')) && (~exist('y_i', 'var'))
    [x_i, y_i] = homework_2_values(); 
end

N = length(x_i);
M = 3;

if (~exist('sigma', 'var'))
    sigma = 1;
    
elseif (exist('sigma', 'var'))
    sigma = sigma_i;
    
else
    warning('Unexpected Error.')
end


alpha = zeros(M, M);
beta = zeros(M, 1);

for i = 1:M
    beta(i) = sum(y_i .* x_i.^(i - 1))./(sigma.^2);
    for j = 1:M
        
       alpha(i, j) = sum(x_i.^(i + j - 2))./(sigma.^2);
        
    end
end

c = inv(alpha);
sigma_sq = zeros(M, M);
for j = 1:M
    sigma_sq(j, j) = c(j, j);
end

x = lu_factorization(alpha, beta);
f_v = x(1) + (x(2) .* x_i) + (x(3) .* x_i.^2);

hold on
plot(x_i, y_i, 'o')
plot(x_i, f_v)
legend('Velocity Data Points','General Least Squares Fit')
title('A General Least Squares Fit Example')

fprintf('Value of a: %f \n', x(2))
fprintf('Value of b: %f \n', x(3))
fprintf('f(v) = %fv + %fv^2 \n', x(2), x(3))

disp('Done.')
end


function [x_i, y_i, sigma_i] = homework_2_values()

vel_dep_forces = importdata('./vel_dep_forces.dat');

x_i = vel_dep_forces(:, 1);
y_i = vel_dep_forces(:, 2);
sigma_i = 1;

%basis_function = @(x) (a * x) + (b * x^2);

end

