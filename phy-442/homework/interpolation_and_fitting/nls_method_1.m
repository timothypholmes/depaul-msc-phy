function nls_method_1(x, y)
clear;

if (~exist('x', 'var')) && (~exist('y', 'var'))
    [x, y] = homework_2_values(); 
end

a(1) =  7;
a(2) =  12;
a(3) =  1;
h = 0.01;

[a, h, x, y] = crude(a, h, x, y); 

plot(x, y, '.', 'MarkerSize', 18)
hold on

fitf = @(x) a(1) * exp(-((x - a(2)).^2)/(2 * a(3)^2));%function with best fit parameters;
plot(x, fitf(x), '-k', 'LineWidth', 4)

end


function [a,h,x,y] = crude(a, h, x, y) 
%%import the data x, y
for i = 1:length(a) 
    % The SUM will be evaluated with the parameters z
    % A_PLUS, A, and A_MINUS: 
    amax = 100;
    tol = 0.00001;  % used to stop while loop
    ict = 0;
    while amax ~=0
    for k = 1:length(a) 
        if(k == i) 
            a_plus(i)  = a(i) + h; 
            a_minus(i) = a(i) - h;
        else 
            a_plus(k)  = a(k); 
            a_minus(k) = a(k); 
        end 
    end 
    sp = LSE(a_plus, x, y); % Evaluate the sums. 
    s0 = LSE(a, x, y); 
    sm = LSE(a_minus, x, y);
    a1=a(i);
    a(i) = a(i) - 0.5 * h * (sp - sm)/(sp - 2 .* s0 + sm); 
    ict = ict + 1;
    if abs(a(i) - a1) < tol
        amax = 0;
    end
    if ict > 10^4  %taking to long, lets just stop
        amax = 0;
    end
    % As we move towards a minimum, we should decrease 
    % step size used in calculating the derivative. 
    
    h = 0.5 * h; 
    end
end
    
end


function [ss] = LSE(a, x, y) 

% The theoretical curve TC is given as 
%
f_x = @(x) a(1) * exp(-((x - a(2)).^2)/(2*a(3)));

ss = 0.; 
len = length(x);
for i = 1:len 
    % evaluate the theoretical curve: 
    TC = f_x(x(i));
    ss = ss + (y(i) - TC).^2; 
end 

end


function [x, y] = homework_2_values()

gaussian = importdata('./gaussian.dat');
x = gaussian(:, 1);
y = gaussian(:, 2);

end