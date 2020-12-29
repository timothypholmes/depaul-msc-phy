function [x] = lu_factorization(A, b)
%% LU Fact
%   - Find unkown x_i values while knowing the
%     matrix and r.h.s array
%   
%   Input Arg
%   ---------
%   A - martix:
%       A general tridiagonal system.
%   r - array:
%       R.H.S values.


if (~exist('A', 'var')) && (~exist('b', 'var'))
    [A, b] = homework_2_values(); 
end

[M, N] = size(A);

if (M ~= N)
    error('Error: Matrix A must be an NxN matrix' );
    return % Kills process
end

%% Prallocate 
L = zeros(N, N); % Lower triangle
U = zeros(N, N); % Upper triangle 

%% LU decomposition
for i=1:N
    %% Fail when any number on the diag = 0 
    if A(i, i) == 0
        warning('LU factorization fails')
        return % Kills process
    else
        %% Find Upper Decomposition
        for k=1:(i - 1)
            L(i, k) = A(i, k);
            for j = 1:(k - 1)
                L(i, k)= L(i, k) - L(i, j) * U(j, k);
            end
            L(i, k) = L(i, k)/U(k, k);
        end
    end

    %% Find Lower Decomposition
    for k = i:N
        U(i, k) = A(i, k);
        for j = 1:(i - 1)
            U(i, k)= U(i, k) - L(i, j) * U(j, k);
        end
    end
    L(i,i)=1;
end

%% Forward Substitution
y = forward_substitution(L, b);  % LY = B

%% Backward Substitution
x = backward_substitution(U, y); % UX = Y

%% Output values
% count = 1:length(x);
% fprintf("The x values are:\n")
% fprintf("  -------------  \n")
% fprintf("    x%d = %0.2f  \n", [count(:), x(:)].')
% fprintf("  -------------  \n")


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

A = [ 1 1/2 1/3 1/4 1/5; 1/2 1/3 1/4 1/5 1/6; 1/3 1/4 1/5 1/6 1/7; 1/4 1/5 1/6 1/7 1/8; 1/5 1/6 1/7 1/8 1/9;];
b = [1; 2; 3; 4; 5;];
end