function [t, y] = myodesolver(to, yo, h, tf, alg)
%driver program to solve odes, alg = 0 euler, alg = 1 modified Euler, else RK4
% Inputs: initial time(to), initial value of function (yo), final time(tf)
% Outputs: A plot of the solution

nsteps = round((tf - to)/h);
t = zeros(nsteps,1);
y = zeros(nsteps,1);
t(1) = to;
y(1) = yo;

for n = 1:nsteps
    if alg == 0
        y(n + 1) = myeuler(t(n), y(n), h);
    elseif alg == 1
        y(n + 1) = myeuler_mid(t(n), y(n), h);
    elseif alg == 2
        y(n + 1) = myrk4(t(n), y(n), h);
    elseif alg == 3
        y(n + 1) = MyAdaptRKFOrig(t(n), y(n), h);
    end
    t(n + 1) = t(n) + h;
end

% figure
% plot(t, y, '.k', 'MarkerSize', 12)
% xlabel('time');
% ylabel('y(t)');
% hold on
% % some plotting stuff follows
% hstr = num2str(h);
% 
% if alg==0
%     ttl = strcat('solution to ODE using euler with h =',hstr);
%     title(ttl)
% elseif alg ==1
%     ttl = strcat('solution to ODE using modified euler with h =',hstr);
%      title(ttl)
% elseif alg == 2
%     ttl = strcat('solution to ODE using Runge-Kutta with h = ', hstr);
%     title(ttl)
% elseif alg == 3
%     ttl = strcat('solution to ODE using Runge-Kutta adapt with h = ', hstr);
%     title(ttl)
% end

end

