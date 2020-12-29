% 0, 10, 0.001, 0.1)
function MyAdaptRKF_problem_5(t0, tf, hmin, hmax) 

[t, y] = rkf(t0, tf, hmin, hmax);% calls the adaptive size stuff

hold on
plot(t(:, :), y(:, :))  
%plot(t(2, :), y(2, :))     

end


function [xx, yy] = rkf(t0, tf, hmin, hmax)
% Inputs initial values, x0,y0. Final time tf, and initial h=hmax
% Outputs: Vectors containing solution


% Specify relative error tolerance.
epsilon = 1.e-5; 

% Specify coefficients used in the R-K-F algorithm: 
%   The coefficients Am are used to determine the 'x' at 
%   which the derivative is evaluated. 
a1 = 0.25; a2 = 0.375; a3 = 12.0/13.0; a4 = 1.0; a5 = 0.5; 

%   The coefficients Bmn are used to determine the 'y' at 
%   which the derivative is evaluated. 
b10 =   0.25;         
b20 = 3.0/  32.0;   b21 =     9.0/  32.0; 
b30 =1932.0/2197.0; b31 = -7200.0/2197.0; b32 =  7296.0/2197.0; 
b40 = 439.0/ 216.0; b41 =    -8.0;        b42 =  3680.0/ 513.0;  b43 = -845.0/4104.0; 
b50 =  -8.0  /27.0; b51 =     2.0;        b52 = -3544.0/2565.0; 
b53 =1859.0/4104.0;  b54 =   -11.0/  40.0; 

%   The Cn are used to evaluate the solution YHAT. 
c0  =    16.0/  135.0; c2 =  6656.0/12825.0; c3 = 28561.0/56430.0;
                       c4 =    -0.18;        c5 = 2.0/55.0; 

%   The Dn are used to evaluate the error. 
d0  =     1.0/  360.0; d2 = -128.0/4275.0;  d3  = -2197.0/75240.0;
                       d4 =    0.02;         d5 = 2.0/55.0; 
% The current point is specified as (x0,y0) and the 
% step size to be used is H. The function DERIVS evaluates 
% the derivative function at (X,Y). The solution is x 
% moved forward one step by: 
h     = hmax;
%hmin  = 0.0001;  %redefine as desired
index = 0;   %used to update indices of xx, yy
S0 = [0; 20; 0; 0;];
xx(1) = t0;
yy(:, 1) = S0
%yy(1) = S0;
while (t0 < tf) 

    f0 = derivs(t0, S0); 
    t  = t0 + a1 * h; 
    S  = S0 + b10*h.*f0; 
    f1 = derivs(t, S); 
    t  = t0 + a2 * h; 
    S  = S0 + (b20 * h .* f0) + (b21 * h .* f1); 
    f2 = derivs(t, S); 
    t  = t0 + a3*h; 
    S  = S0 + h.*(b30*f0+b31*f1+b32*f2); 
    f3 = derivs(t, S); 
    t  = t0 + a4*h; 
    S  = S0 + h.*(b40*f0+b41*f1+b42*f2+b43*f3); 
    f4 = derivs(t, S); 
    t  = t0 + a5*h; 
    S  = S0 + h.*(b50*f0+b51*f1+b52*f2+b53*f3+b54*f4);
    f5 = derivs(t, S); 

    yhat   = S0 + h .* (c0*f0 + c2*f2 + c3*f3 + c4*f4 + c5*f5);
    RelErr = abs (h.*(d0*f0 + d2*f2 + d3*f3 + d4*f4 + d5*f5)./yhat); 
    hnew   = h .* (epsilon./RelErr).^0.2; 
    if hnew > hmax
        hnew = hmax;
    end
    if hnew < hmin
       error(strcat('\n Possible Problem: "hnew" is too small \n',...
	'x0=  %11.8f\n hnew = %8.4gf < hmin = \%8.4g'), t0, hnew, hmin)
    end 

    if( hnew >= h )       % The error is small enough.  Accept the
        t0 = t0 + h;    %   solution, and move it along.
        S0 = yhat
        index = index + 1;
        xx(1, index) = t0(1, 1);
        xx(2, index) = t0(2, 1);
        yy(1, index) = yhat(1, 1);  % keep the higher order result.
        yy(2, index) = yhat(2, 1);
        

    end
        h = 0.9 * hnew;       % Redefine h.  Note that if the error had been too                             
                             % large, we'd now repeat the step with a smaller h.                    % large, we'd now repeat the step with a smaller h.
end

        
end


function [der] = derivs(t, S) 

g = 9.81;
c = 0.1;
Vx = S(1);
Vy = S(2);
der = [Vx; -c*sqrt(Vx^2 + Vy^2) * Vx; Vy; -c*sqrt(Vx^2 + Vy^2) * Vy];

end 