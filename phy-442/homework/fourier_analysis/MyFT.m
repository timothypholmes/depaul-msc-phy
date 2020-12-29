function MyFT() 
% This function performs the Fourier Transform by Recursion. 
%  
w = 1;
a = 10;
fun = @(t,a) (a * (1 - a*abs(t)));
% 
F = 1/(2*pi) * integral(@(t) fun(t,A) .* exp(-1*1i*t), -Inf, ...
                        Inf, 'RelTol', 0, 'AbsTol', 1e-5);
                    
fprintf("Value of f: %f \n", F);
end