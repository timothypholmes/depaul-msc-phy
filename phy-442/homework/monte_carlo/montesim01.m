function montesim01(n,r)
%Drunken Sailor simulation

% first some stuff to plot grid points

if (~exist('n', 'var')) && (~exist('r', 'var')) 
    [n, r] = sample_data(); 
end

xy = 1:n;
[X, Y] = meshgrid(xy);
% xyo = xy([4 11]);
figure(1)
plot(X, Y, '.k')
hold on

% starting pint
x = n/2;
y = n/2;
% starting simulation
for j = 1:r
    stp = rand;
    if stp<.25 % step left
        %x = x -1;
        u = -1;
        v = 0;
    elseif stp>0.25 && stp<0.50 % move up
        %y = y + 1;
        u = 0;
        v = 1;
    elseif stp>0.5 && stp<0.750 % move right
        %x = x + 1;
        u = 1;
        v = 0;
    elseif stp>0.75 && stp<1 % move down
        %y = y - 1;
        u = 0;
        v = -1;
    end
    quiver(x,y,u,v)
    x = x +u;
    y = y + v;
    hold on
    pause(0.000001)
end
end



function [n, r] = sample_data()

n = 10;
r = 10000;
 
end