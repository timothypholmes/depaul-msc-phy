function nls_method_2(x, y)
clear;

if (~exist('x', 'var')) && (~exist('y', 'var'))
    [x, y] = homework_2_values(); 
end

a(1) =  7;  
a(2) =  12;
a(3) =  1;
h = linspace(0.01, 0.05, 3); 

[a, h, x, y] = crude(a, h, x, y); 

plot(x, y, '.', 'MarkerSize', 18)
hold on

fitf = @(x) a(1) * exp(-((x - a(2)).^2)/(2 * a(3)^2));%function with best fit parameters;
plot(x, fitf(x), '-k', 'LineWidth', 4)

end


function [a, h, x, y] = crude(a, h, x, y) 
%%import the data x, y

m = length(a);
hessian = zeros(m, m);

for i = 1:m
    for j = 1:m
        if i==j
            for k = 1:m
                ap(k) = a(k);
                am(k) = a(k);
            end
                ap(i) = a(i) + h(i);
                am(i) = a(i) - h(i);
                hessian(i,i) =(LSE(ap, x, y) -2*LSE(a, x, y)+LSE(am, x, y))/(h(i) *h(i));
        else
            for k = 1:m
                app(k) = a(k);
                apm(k) = a(k);
                amp(k) = a(k);
                amm(k) = a(k);
            end
            app(i) = a(i) + h(i);
            app(j) = a(j) + h(j);
            % amp and amm work similarly
            hessian(i,j) = ((LSE(app, x, y) - LSE(apm, x, y))/(2*h(j))-...
                (LSE(amp, x, y)-LSE(amm, x, y))/(2*h(j)))/(2*h(i));
            hessian(j,i) = hessian(i,j);
        end
    end
end


%x = lu_factorization(hessian, a);
delta = LUF20solve(hessian, a, 3);
fprintf('%f', x)


for i = 1:m
    if delta(i) > 0.001
        a(i) = a(i) + delta(i);
    else
        delta(i) = 0;
    end
end

end


    

function [ss] = LSE(a, x, y)

% The theoretical curve TC is given as 
% a(1) *exp(-(x(i)-a(2)).^2/(2*a(3)))
ss = 0.; 
len = length(x);
for i = 1:len 
   % evaluate the theoretical curve: 
   TC= a(1) *exp(-(x(i)-a(2)).^2/(2*a(3)));   %??
   ss=ss+(y(i)-TC).^2; 
end 
end


function [x, y] = homework_2_values()

gaussian = importdata('./gaussian.dat');
x = gaussian(:, 1);
y = gaussian(:, 2);

end