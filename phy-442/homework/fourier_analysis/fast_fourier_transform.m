function [A] = fast_fourier_transform(A, m)
%% Fourier Series
%   - Find unkown x_i values while knowing the
%     matrix and r.h.s array
%   
%   Input Arg
%   ---------
%   A - martix:
%       A general tridiagonal system.
%   r - array:
%       R.H.S values.

%   Optional Input
%   --------------
%   None
%       Runs func that rutens homework 1 Args
%
%   Output Arg
%   ----------
%   None - prints unknow x_i values to console
%
%   Modify for output arg, change function to:
%       [x] = function tridiagonal_system(A, r)
if (~exist('A', 'var')) && (~exist('m', 'var'))
    [A, m] = sample_data();
end

N = 2^m;
Nd2 = N/2;

if (N == 1)
    A = A;
    
else
    even = zeros(1, Nd2);
    odd  = zeros(1, Nd2);
    
    for k = 1:Nd2
        even(k) = A(k + k);
        odd(k)  = A(k + k - 1);
    end
    
    q = zeros(1, Nd2);
    r = zeros(1, Nd2);

    q = fast_fourier_transform(even, m - 1);
    r = fast_fourier_transform(odd, m - 1);

    for k = 1:Nd2
        ang = -2 * (k - 1) * pi/N;
        ck = complex(cos(ang), sin(ang));
        A(k)       = q(k) + ck * r(k);
        A(k + Nd2) = q(k) - ck * r(k);

    end
end

end

function [A, m] = sample_data()

A = [1,2,3,4,5];
m = 2;

end