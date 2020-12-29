function homework_4()

%problem_1()  
problem_2()
%problem_3()
%problem_4()
%problem_5()

end

function problem_1()

t0 = 0;
y0 = 3;
h  = [1, 0.2, 0.1, 0.05];
tf = 5;

for i = 1:length(h)
    [t1, y1] = myodesolver(t0, y0, h(i), tf, 0);
    [t2, y2] = myodesolver(t0, y0, h(i), tf, 1);
    [t3, y3] = myodesolver(t0, y0, h(i), tf, 2);
    %myodesolver(t0, y0, h(i), tf, 3)
    
    hold on
    figure(1)
    plot(t1, y1, '.', 'MarkerSize', 12)
    xlabel('time');
    ylabel('y(t)');
    legend('h = 1', 'h = 0.2', 'h = 0.1', 'h = 0.05')
    
    hold on
    figure(2)
    plot(t2, y2, '.', 'MarkerSize', 12)
    xlabel('time');
    ylabel('y(t)');
    legend('h = 1', 'h = 0.2', 'h = 0.1', 'h = 0.05')
      
    hold on
    figure(3)
    plot(t3, y3, '.', 'MarkerSize', 12)
    xlabel('time');
    ylabel('y(t)');
    legend('h = 1', 'h = 0.2', 'h = 0.1', 'h = 0.05')
end

% analytic solution

% figure(2)
% hold on
% t = 0:0.01:10;
% c = exp(-exp(t))*cot(3/2);
% y = 2*acot(exp(c - exp(t)));
% 
% plot(t, y)

end

function problem_2()

    y0 = 0;
    tspan=[0, 10];
    g = 9.81;    %m/s^2
    m = 10^(-2); %kg
    k = 10^(-4); %kg/m
 
    [t, y] = ode45(@(t, y) (((m * g) - (k * (y)^2)) * -t), tspan, y0);
    plot(t, y)
    xlabel('time');
    ylabel('y(t)');
    %hmax = 0.01;
    %MyAdaptRKF1D(t0, y0, tf, hmax) 

end


function problem_3()

    t0 = -1;
    tf = 1;
    y0 = 1;
    hmax = 0.1;
    MyAdaptRKF_problem_3(t0, y0, tf, hmax) 
    
end

function problem_4()

    x0 = 20;
    y0 = 0;
    t0 = 0;
    tf = 10;
    hmin = 0.001;
    hmax = 0.1;
    MyAdaptRKF(x0, y0, t0, tf, hmin, hmax) 
     
end

function problem_5()
     return;
end