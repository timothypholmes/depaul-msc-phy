function [x] = lu_factorization(A, b)
%% Tridiagonal Program
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

if (~exist('A', 'var')) && (~exist('b', 'var'))
    [A, b] = homework_2_values(); 
end

[M N] = size(A);

if (M ~= N)
    error('Error: Matrix A must be an NxN matrix' );
    return % Kills process
end

%% Prallocate 
L = zeros(N, N); % Lower triangle
U = zeros(N, N); % Upper triangle 
for i=1:N
    if A(i, i) == 0
        warning('LU factorization fails')
        return % Kills process
    else
        for k=1:(i - 1)
            L(i, k) = A(i, k);
            for j = 1:(k - 1)
                L(i, k)= L(i, k) - L(i, j) * U(j, k);
            end
            L(i, k) = L(i, k)/U(k, k);
        end
    end
end

for i = 1:N
    for k = i:N
        U(i, k) = A(i, k);
        for j = 1:(i - 1)
            U(i, k)= U(i, k) - L(i, j) * U(j, k);
        end
    end
end
% 
% for i=1:N
%     L(i,i)=1;
% end
  % Program shows U and L
  U
  L

y = forward_substitution(L, b);  % LY = B
x = backward_substitution(U, y); % UX = Y

%% Output values
count = 1:length(x);
fprintf("The x values are:\n")
fprintf("  -------------  \n")
fprintf("    x%d = %0.2f  \n", [count(:), x(:)].')
fprintf("  -------------  \n")


end


function [y] = forward_substitution(L, b)

N = size(L, 1);
y(1, :) = b(1, :)/L(1, 1);
for i = 2:N
    y(i, :) = (b(i, :) - L(i, 1:(i - 1)) * y(1:(i - 1), :))/L(i, i);
end

end


function [x] = backward_substitution(U, y)

N = size(U, 2);
U(N,N)
x(N, :) = y(N, :)/U(N, N);
for i = (N - 1):-1:1
    x(i, :) = (y(i, :) - U(i, (i + 1):N) * x((i + 1):N, :))/U(i, i);
end

end


function [A, b] = homework_2_values()
A = [ 2 -1   0   0  0; -1  2  -1   0  0; 0 -1   2  -1  0; 0  0  -1   2 -1; 0  0   0  -1  2;];
b = [0; 1; 2; 3; 4;];
end