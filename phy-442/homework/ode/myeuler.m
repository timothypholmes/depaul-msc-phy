function yoft = myeuler(tn, yn, h )
%myeuler steps the solution to ODE using Euler's method 
% Input: current values of time, y, and stepsize
% Output: yoft, time evolution of this point 

% note you must edit and replace dydt with RHS of ODE
yoft = yn - (exp(tn) * sin(yn)) * h;%yn - (2*tn^2*yn*h);
end
