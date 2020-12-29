function runge_kutta_method(t0, tf, y0, h, func)
%% Runge Kutta Method
%   - Curve fit
%   
%   Input Arg
%   ---------
%   t0 - function: Default: data
%       Some function
%   tf - float: Default: data
%       x_lower_bound
%   y0 - float: Default: data
%       x_upper_bound
%   h - float: Default: data
%       y_lower_bound
%   func - float: Default: data
%       y_upper_bound
%
disp('Running')
disp('-------')
if (~exist('t0', 'var')) && (~exist('tf', 'var')) && (~exist('y0', 'var')) && (~exist('h', 'var')) && (~exist('func', 'var'))
    [t0, tf, y0, h, func] = sample_data();
end

t    = t0:h:tf;        % the range of x
y    = zeros(size(t)); % allocate the result y
y(1) = y0;             % the initial y value
n    = length(t);

for i = 1:(n - 1)
    
    k1 = func(t(i), y(i));
    k2 = func(t(i) + 0.5 * h, y(i) + 0.5 * h * k1);
    k3 = func((t(i) + 0.5 * h), (y(i) + 0.5 * h * k2));
    k4 = func((t(i) + h), (y(i) + k3 * h));
    
    
    y(i + 1) = y(i) + (1/6) * (k1 + 2 * k2 + 2 * k3 + k4) * h;
    
end

%[t_ode45, y_ode45] = ode45(func, t, y0);

figure(1)
hold on
plot(t, y)
%plot(t_ode45, t_ode45)

% y_c2 = y_ode45';
% 
% disp('Error between Runge-Kutta and ode45')
% err = immse(y, y_c2);
% fprintf("Error between Runge-Kutta and ode45: %f", err)
 
end


function [t0, tf, y0, h, func] = sample_data()

h    = 0.05;
y0   = 3;
t0   = 0;
tf   = 5;
func = @(t, y) exp(t) .* sin(y);

end



% function runge_kutta_method()
% tstep = 10000;
% ymin = 0;
% ymax = 6;
% y = 5;
% y2 = 5;
% ti = 0;
% tf = 10;
% dt = tf/tstep;
% t = ti:dt:tf;
% 
% [t, y] = ode45(@(t, y) exp(t) * sin(y), t, y); 
% 
% figure(1)
% plot(t,y, 'g');
% xlabel('time')
% ylabel('y(t)')
% title('Runge-Kutta Method')
% axis([0,5,2,5])
% %figure(2)
% [t2, y2] = eulers(0, 10,5,tstep); 
% plot(t2,y2, 'g');
% xlabel('time')
% ylabel('y(t)')
% title('Eulers Method')
% axis([0,10,0,10])
% 
% end
%  
% function [t2, y] = eulers(ti, tf, yi, tstep)
% 
% dt = (tf - ti)/tstep;
% t = ti:dt:tf;
% y = zeros(1,tstep+1);
% y(1) = [yi];
% i = 1;
% f = [];
% t2(1)=ti;
% for t = ti:dt:(tf)
%     f(i) = eq8(y(i),t);
%     y(i+1) = y(i)+(dt*f(i)); 
%     t2(i+1) = t+dt;
%     i = i+1;
% end
% 
% end
% 
% function [ymin, ymax, t0, tf, h] = sample_data()
% 
% ymin = 0;
% ymax = 5; 
% t0   = 0;
% tf   = 5; 
% h    = 1;
% 
% end