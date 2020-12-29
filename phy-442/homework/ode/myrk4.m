function yoft=myrk4(tn, yn, h)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% RHS=@(t,y) (exp(t)*sin(y)); % note you must edit and replace dydt with RHS of ODE
% g = 9.8;
% k = 10^(-4);
% m = 10^(-2);
RHS  = @(t,y) (exp(t)*sin(y)); 
fo   = RHS(tn,yn);
f1   = RHS(tn+h/2,yn+h/2*fo);
f2   = RHS(tn+h/2,yn+h/2*f1);
f3   = RHS(tn+h,yn+h*f2);
yoft = yn +h/6*(fo+2*f1+2*f2+f3);

end

