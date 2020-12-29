function test()


% % problem 1
% tspan = [0 10];
% %tspan = 0:1:10;
% [t, y] = ode45(@(t,y) exp(t) * sin(y), tspan, 3);
% plot(t, y)

% % problem 2
% g = 9.81;    %m/s^2
% m = 10^(-2); %kg
% k = 10^(-4); %kg/m
% y0 = 0;
% tspan = [0 10];
% [t, y] = ode45(@(t, y) ((m * g) - (k * (y/t)^2)), tspan, y0);
% plot(t, y)

% problem 3
tspan = [-1 1];
[t, y] = ode45(@(t,y) 1/t^2, tspan, y0);
plot(t, y)

% problem 4
[t, y] = ode45(@(t,y) 1/t^2, tspan, y0);
plot(t, y)

% problem 5
[t, y] = ode45(@(t,y) 2*t, tspan, y0);
plot(t, y)

end