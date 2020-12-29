function [x] = trisolve(A, r)
%% Tridiagonal Program
%   - Find unkown x_i values while knowing the
%     matrix and r.h.s array
%   
%   Input Arg
%   ---------
%   A - martix: Default: Homework 1 values
%       A general tridiagonal system.
%   r - array: Default: Homework 1 values
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

if (~exist('A', 'var')) && (~exist('r', 'var'))
    [A, r] = homework_1_values(); 
end

%% Define variables   
N = length(A);          % Returns largest array dim in matrix
a = [(0); diag(A, -1)]; % diag at first col second row
b = diag(A);            % diag of matix
c = [diag(A, 1); 0];    % diag of second col first row

% Preallocate beta, rho
beta = zeros(1, N);
rho  = zeros(1, N);

%% Run calculations
% Initial values are beta_1 = b_1 and rho_1 = r_1
beta(1)  = b(1);
rho(1)   = r(1);

for j = 2:N
    beta(j) = b(j) - a(j)/beta(j - 1) * c(j - 1);
    rho(j)  = r(j) - a(j)/beta(j - 1) * rho(j - 1);
end

% Final row of matrix
x(N) = rho(N) / beta(N);

% Repeat for all row
for j = 1:N-1
    x(N - j) =  (rho(N - j) - c(N - j) * x(N - j + 1)) / beta(N - j);
end

%% Output values
% count = 1:length(x);
% fprintf("The x values are:\n")
% fprintf("-----------------\n")
% fprintf("    x%d = %0.2f  \n", [count(:), x(:)].')
% fprintf("-----------------\n")

end


function [A, r] = homework_1_values()
A = [ 2 -1   0   0  0; -1  2  -1   0  0; 0 -1   2  -1  0; 0  0  -1   2 -1; 0  0   0  -1  2;];
r = [0; 1; 2; 3; 4;];
end