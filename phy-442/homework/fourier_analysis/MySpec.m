function MySpec(A, m, t)

F = MyFFT(A,m);
omega =linspace(0,2*pi/length(t),2^m);
figure
F = abs(F);
figure
plot(omega(2:2^(m-1)),F(2:2^(m-1)))
ttl1 = num2str(256/2^m);
ttl2 = strcat('Spectrum for sampling every - ',ttl1,' points');
title(ttl2)

end
function [A] = MyFFT(A,m) 
% This function performs the Fast Fourier Transform by Recursion. 
%  
% The array A contains the complex data to be transformed and 'm' is 
% log2(N).
%  
%  

N = 2^m; 
Nd2 = N/2; 
if(N==1) 
     A = A; % don't need to do anything 
else 
    even = zeros(1,Nd2); % Data 
    odd  = zeros(1,Nd2); % Data 

    for k = 1:Nd2 
        even(k) = A(k+k-1); 
        odd(k)  = A(k+k ); 
    end 
    q = zeros(1,Nd2); % Data 
    r = zeros(1,Nd2); % Data 

    q = MyFFT(even, m-1); 
    r = MyFFT( odd, m-1);

    for k = 1:Nd2 
        ang = -2*(k-1)*pi/N; 
        ck  = complex(cos(ang), sin(ang)); 
        A(  k  ) = q(k)+ck*r(k);
        A(k+Nd2) = q(k)-ck*r(k);
   
    end 
end 

end
