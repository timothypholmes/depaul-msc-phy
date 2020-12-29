function homework_6()

    fprintf('Enter an integer for what problem you want to run 1-5\n')
    prompt = input('What problem do you want to run? \n problem: ');


    if prompt == 1
        problem_1()

    elseif prompt == 2
        problem_2()

    elseif prompt == 3
        problem_3()

    elseif prompt == 4
        problem_4()

    elseif prompt == 5
        problem_5()

    else
        fprintf("Invalid input")
        
    end

end

function problem_1()

    N = 33;  % Grid size
    maxiter = 1000;
    
    x0 = 0;
    dx = N;
    xf = 33;
    t0 = 0;
    dt = N;
    tf = 33;
    
    x = linspace(x0, xf, N)';
    t = linspace(t0, tf, N)';
    
    u0x = 100;
    ufx = 0;
    u0t = 100;
    uft = 0;

    u = MyHeatEq(N, maxiter, u0t, u0x, uft, ufx);

    hold on
    figure(1)
    [x, t] = meshgrid(x, t);
    surf(x, t, u);
    mesh(x, t, u);
    xlabel('Position');
    ylabel('Time');
    zlabel('Temperature');
    
    hold on
    figure(2)
    contour(x, t, u)
    xlabel('Position');
    ylabel('Time');
    zlabel('Temperature');
    
    fprintf("There is a pause, press any button to continue")
    pause;
    
    u0x = 0;
    ufx = 100;
    u0t = 0;
    uft = 100;
    
    x = linspace(x0, xf, dx)';
    t = linspace(t0, tf, dt)';

    u = MyHeatEq(N, maxiter, u0t, u0x, uft, ufx);
    
    size(u)
    
    hold on
    figure(3)
    [x, t] = meshgrid(x, t);
    surf(x, t, u);
    mesh(x, t, u);
    xlabel('Position');
    ylabel('Time');
    zlabel('Temperature');
    
    hold on
    figure(4)
    contour(x, t, u)
    xlabel('Position');
    ylabel('Time');
    zlabel('Temperature');
    
end

function problem_2()

    tau      = 10;     % N Tension
    m        = 0.001;  % kg mass
    x0       = 0;      % x init
    xl       = 1;      % m
    x_length = (xl - x0);
    maxtime  = 20;     % 20time steps
    hx       = 0.01;   % cm
    dt       = 0.0001; % s
    
    N      = round(x_length/hx);
    x      = linspace(x0, xl, N);
   
    du0    = zeros(1, N);
    
    u  = exp(-100 * (x - 0.5).^(2));
    u0 = u;
    
    %u0(1)  = 0.0; 
    u0(N)  = 0.0; 
    
    mu =  m/x_length; % m density 
    c = sqrt(tau/mu); %tau/m

    MyString(c, x, x_length, u, u0, du0, N, maxtime, hx, dt)

end

function problem_3()

    tau      = 25;     % N Tension
    m        = 0.001;  % kg mass
    x0       = 0;      % x init
    xl       = 1;      % m
    x_length = (xl - x0);
    maxtime  = 20;     % 20time steps
    hx       = 0.01;   % cm
    dt       = 0.0001; % s
    
    N      = round(x_length/hx);
    x      = linspace(x0, xl, N);
   
    du0    = zeros(1, N);
    
    u  = exp(-100 * (x - 0.5).^(2));
    u0 = u;
    
    %u0(1)  = 0.0; 
    u0(N)  = 0.0; 
    
    mu =  m/x_length; % m density 
    c = sqrt(tau/mu); %tau/m

    MyString(c, x, x_length, u, u0, du0, N, maxtime, hx, dt)

end

function problem_4()

    tau      = 10;     % N Tension
    m        = 0.001;  % kg mass
    x0       = 0;      % x init
    xl       = 1;      % m
    x_length = (xl - x0);
    maxtime  = 20;     % 20time steps
    hx       = 0.01;   % cm
    dt       = 0.0001; % s
    
    N = round(x_length/hx);
    x = linspace(x0, xl, N);
    
    mu =  m/x_length; % m density 
    c = sqrt(tau/mu); %tau/m
    
    t   = 0;
    u   = exp(-100 * (x + (c * t) - 0.5).^(2));
    u0  = u;
    du0 = -200 * c * (x - 0.5).*exp(-100 * (x + (c * t) - 0.5).^2); 
    
    %u0(1)  = 0.0; 
    u0(1)  = 0.0; 
    du0(1) = 0;
    u0(N)  = 0.0; 

    MyString(c, x, x_length, u, u0, du0, N, maxtime, hx, dt)

end

function problem_5()

    tau      = 10;     % N Tension
    m        = 0.001;  % kg mass
    x0       = 0;      % x init
    xl       = 1;      % m
    x_length = (xl - x0);
    maxtime  = 20;     % 20time steps
    hx       = 0.01;   % cm
    dt       = 0.0001; % s
    
    N = round(x_length/hx);
    x = linspace(x0, xl, N);
    
    mu =  m/x_length; % m density 
    c = sqrt(tau/mu); %tau/m
    
    t   = 0;
    u   = exp(-100 * (x + (c * t) - 0.5).^(2));
    u0  = u;
    du0 = -200 * c * (x - 0.5).*exp(-100 * (x + (c * t) - 0.5).^2); 
    
    %u0(1)  = 0.0; 


    MyString(c, x, x_length, u, u0, du0, N, maxtime, hx, dt)

end













