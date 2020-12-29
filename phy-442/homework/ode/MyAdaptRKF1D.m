function MyAdaptRKF1D(x0, y0, tf, hmax) 

[t, y] = rkf(x0, y0, tf, hmax);  % calls the adaptive size stuff
plot(t, y)                  % plots results

end

function [xx,yy] = rkf(x0, y0, tf, hmax)
% tol
epsilon = 1.e-5; 

a1 = 0.25; a2 = 0.375; a3 = 12.0/13.0; a4 = 1.0; a5 = 0.5; 
b10 =   0.25;         b20 =     3.0/  32.0; b21 =     9.0/  32.0; 
b30 =1932.0/2197.0;   b31 = -7200.0/2197.0; b32 =  7296.0/2197.0; 
b40 = 439.0/ 216.0;   b41 =    -8.0;        b42 =  3680.0/ 513.0;  
                      b43 = -845.0/4104.0; 
b50 =  -8.0  /27.0;   b51 =     2.0;        b52 = -3544.0/2565.0; 
                      b53 =1859.0/4104.0;   b54 =   -11.0/  40.0; 
c0  =    16.0/  135.0; c2 =  6656.0/12825.0; c3 = 28561.0/56430.0;
                       c4 =    -0.18;        c5 = 2.0/55.0; 
d0  =     1.0/  360.0; d2 = -128.0/4275.0;  d3  = -2197.0/75240.0;
                       d4 =    0.02;         d5 = 2.0/55.0; 

                       
h = hmax;
hmin = 0.0001;  %redefine as desired
index = 1;   %used to update indices of xx, yy
xx(1) = x0;
yy(1) = y0;

while (x0 < tf) 

    f0 = derivs(x0,y0); 
    x  = x0 + a1*h; 
    y  = y0 + b10*h*f0; 
    f1 = derivs(x,y); 
    x  = x0 + a2*h; 
    y  = y0 + b20*h*f0 + b21*h*f1; 
    f2 = derivs(x,y); 
    x  = x0 + a3*h; 
    y  = y0 + h*(b30*f0+b31*f1+b32*f2); 
    f3 = derivs(x,y); 
    x  = x0 + a4*h; 
    y  = y0 + h*(b40*f0+b41*f1+b42*f2+b43*f3); 
    f4 = derivs(x,y); 
    x  = x0 + a5*h; 
    y  = y0 + h*(b50*f0+b51*f1+b52*f2+b53*f3+b54*f4); 
    f5 = derivs(x,y); 

    yhat   = y0 + h*(c0*f0 + c2*f2 + c3*f3 + c4*f4 + c5*f5); 
    RelErr = abs (h*(d0*f0 + d2*f2 + d3*f3 + d4*f4 + d5*f5)/yhat); 
    hnew   = h * (epsilon/RelErr)^0.2; 
    
    if hnew>hmax
        hnew = hmax;
    end
    
    if hnew< hmin
       error(strcat('\n Possible Problem: "hnew" is too small \n',...
	'x0=  %11.8f\n hnew = %8.4gf < hmin = \%8.4g'),x0,hnew,hmin)
    end 

    if( hnew >= h )       % The error is small enough.  Accept the
        x0 = x0 + h;      %   solution, and move it along.
        y0 = yhat;        
        index = index +1;
        xx(index) = x0;
        yy(index) = yhat;  % keep the higher order result.

    end
        h = 0.9 * hnew;       % Redefine h.  Note that if the error had been too                             
                             % large, we'd now repeat the step with a smaller h.
end 

end
function [der] = derivs(x, y) 

g = 9.81;    %m/s^2
m = 10^(-2); %kg
k = 10^(-4); %kg/m
der = (m * g) - (k * y^2);

end 
