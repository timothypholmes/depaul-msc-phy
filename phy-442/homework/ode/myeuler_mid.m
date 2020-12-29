function yoft = myeuler_mid(tn, yn, h)
% Mid-point Euler method
% you must edit f for your particular ODE.


ymid = yn + h/2 * f(0, 3);
tmid = tn + h/2;
yoft = yn - h * f(tmid, ymid);
end

function [der] = f(t, y)

der = exp(t) * sin(y);

end
