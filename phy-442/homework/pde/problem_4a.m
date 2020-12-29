% U_0 is the initial u at t=0, and dU_0 is the time derivative 
%   evaluated at t=0, the initial conditions of the problem.
%  
Tension = 10;
mass    = 0.001;
len     = 1;
maxtime = 20;
dx      = 0.01;
dt      = 0.0001;

mu =  mass/len;        % mass density 
c  = sqrt(Tension/mu);         % wave velocity 
epsilon = (dt*c/dx); % Needs to remain < 1 to insure stability 

N = round(len/dx);
x = linspace(0,len,N);
U = zeros(1,N);
U_0 = zeros(1,N);
Unew = zeros(1,N);
t = 0;
U = exp(-100*(x+c*t-0.5).^2); %initial condition     
U_0 = U;
% U_0(1) = 0.0; 
U_0(N) = 0.0; 
dU_0   = -200*c*(x-0.5).*exp(-100*(x+c*t-0.5).^2); 
Uold   = U_0; 
% U(endpoints) are fixed, = 0. 
 
for i = 2: N-1     % Initial time step 
    U(i)=0.5*epsilon*(U_0(i+1)+U_0(i-1))+... 
         (1.0-epsilon) * U_0(i) + dt * dU_0(i); 
end 
%
%% Start main time loop 
% tdisp = 0;
fprintf("run\n")
time = 0;
while time < maxtime 
    
    time    = time + dt;
 
    for i = 2: N-1 
        Unew(i) = epsilon * ( U(i+1) + U(i-1) ) + ... 
             2.d0 * (1.0-epsilon) * U(i) - Uold(i); 
         
    end 
    % Shuffle arrays, and animate ... 
    Uold = U; 
    U    = Unew; 
    pause(0.01);
    plot(x, U, 'MarkerSize', 8)  % Animation Step 2: plot the new data
    %plot(x, U)
    axis([0 1 -1 1])
end