function dirfield(tmin, tmax, ymin, ymax, n)
% function plots direction field. 
% Inputs are the min and max values for meshgrid, and n, the
% number of points between the min and max values
if (~exist('tmin', 'var')) && (~exist('tmax', 'var')) && (~exist('ymin', 'var')) && (~exist('ymax', 'var')) && (~exist('n', 'var'))
    [tmin, tmax, ymin, ymax, n] = sample_values(); 
end

delt = (tmax-tmin)/n; % t-step size
dely = (ymax-ymin)/n; % y-step size
[t,y] = meshgrid(tmin:delt:tmax,ymin:dely:ymax);
dy = exp(t).*sin(y); % note you must edit and replace dydt with RHS of ODE
dt=ones(size(dy));
dtu = dt./sqrt(dt.^2 + dy.^2);
dyu= dy./sqrt(dt.^2 + dy.^2);
quiver(t,y,dtu,dyu)
xlabel('t')
ylabel('y(t)')
title('slopefield for dy/dt exp(t) sin(y)')

end


function [tmin, tmax, ymin, ymax, n] = sample_values()

tmin = 0;
tmax = 1;
ymin = -1;
ymax = 1;
n    = 100;

end

