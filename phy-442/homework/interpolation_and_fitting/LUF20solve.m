
function [x,det] = LUF20solve(a,b,N) 
% This function solves the linear set of equations 
% 
%          A x = b 
% 
% by the method of L U decomposition. 
% 
% INPUT:  N  the actual size of the arrays for this problem 
%         A  an N by N array of coefficients, altered on output  
%         b  a vector of length N 
%  
% OUTPUT: x  the 'solution' vector 
%       det  the determinant of A. If the determinant is zero,    
%              then the matrix A is SINGULAR. 
%  

det = 1.0; 
% None of this needed if no l = 0. It is added in case that
% is the case. First, determine a scaling factor for each row. (We 
% could "normalize" the equation by multiplying by this 
% factor. However, since we only want it for comparison 
% purposes, we don't need to actually perform the 
% multiplication.) 
for i = 1:N 
    order(i) = i; 
    max = 0.; 
    for j = 1:N 
        if(abs(a(i,j)) > max), max = abs(a(i,j)); end 
    end 
    scale(i) = 1./max; 
end 

% Start the LU decomposition. The original matrix A 
% will be overwritten by the elements of L and U as 
% they are determined. The first row and column 
% are specially treated, as is L(N,N). 
for k = 1:N-1 
    % Do a column of L 
    if( k == 1 ) 
        % No work is necessary. 
    else 
        % Compute elements of L from Eq.\ 2.45 
        for i = k:N 
            sum = a(i,k); 
            for j = 1: k-1 
                sum = sum - a(i,j)*a(j,k); 
            end 
            a(i,k) = sum;           % Put L(i,k) into A. 
        end 
    end 
    % Do we need to interchange rows? We want the largest 
    % (scaled) element of the recently computed column of L 
    % moved to the diagonal (k,k) location. 
    max = 0.; 
    for i = k:N 
        if(scale(i)*a(i,k) >= max) 
            max = scale(i)*a(i,k); 
            imax=i; 
        end 
    end 
    % Largest element is L(imax,k). If imax=k, the largest 
    % (scaled) element is already on the diagonal. 
    if(imax == k) 
                                   % No need to exchange rows. 
    else 
                                   % Exchange rows... 
        det = -det; 
        for j = 1:N 
            temporary = a(imax,j); 
            a(imax,j) = a(k,j); 
            a(k,j)    = temporary; 
        end 
                                   % scale factors... 
        temporary   = scale(imax); 
        scale(imax) = scale(k); 
        scale(k)    = temporary; 
                                   % and record changes in the ordering 
        itemp       = order(imax) ; 
        order(imax) = order(k); 
        order(k)    = itemp; 
    end 
    det = det * a(k,k); 
    % Now compute a row of U. 
    if(k==1) 
        %  The first row is treated special, 
        for j = 2:N 
            a(1,j) = a(1,j) / a(1,1); 
        end 
    else 
        % Compute U(k,j) from Eq.\  2.46 
        for j = k+1:N 
            sum = a(k,j); 
            for i = 1:k-1 
                sum = sum - a(k,i)*a(i,j); 
            end 
            % Put the element U(k,j) into A. 
            a(k,j) = sum / a(k,k); 
        end 
    end 
end 
% Now, for the last element of L 
sum = a(N,N); 
for j = 1:N-1 
    sum = sum - a(N,j)*a(j,N); 
end 
a(N,N) = sum; 
det = det * a(N,N)

% LU decomposition is now complete. 

% We now start the solution phase. Since the equations 
% have been interchanged, we interchange the elements of 
% B the same way, putting the result into X. 
for i = 1:N 
    x(i) = b(order(i)); 
end 
                              % Forward substitution... 
x(1) = x(1) / a(1,1); 
for i = 2:N 
    sum = x(i); 
    for k = 1:i-1 
        sum = sum - a(i,k)*x(k); 
    end 
    x(i) = sum / a(i,i); 
end 
                             % and backward substitution... 
for i = 1:N-1 
    sum = x(N-i); 
    for k = N-i+1:N 
        sum = sum - a(N-i,k)*x(k); 
    end 
    x(N-i) = sum; 
end 
                             % We're done! 
