function pdf


x = importdata('./x-square-pdf.dat');
N = length(x);


sample_mean = sample_mean_function(x, N);
sample_variance = sample_variance_function(x, N, sample_mean);

n = 100;
for i = 1:n
    x_rand = rand(1, i);
end

p_x = 3 * x.^2;

p_x_mean = sample_mean_function(p_x, n);
p_x_var = sample_variance_function(p_x, n, p_x_mean);

fprintf('%f \n', mean(p_x))
fprintf('%f \n', var(p_x))

end

function [sample_mean] = sample_mean_function(x, N)

sample_mean = sum(x)/N;
fprintf('Sample Mean: %f \n', sample_mean)

end

function [sample_variance] = sample_variance_function(x, N, sample_mean)

sample_variance = (sum(x) - sample_mean)^2/(N - 1);
fprintf('Sample Variance: %f \n', sample_variance)

end