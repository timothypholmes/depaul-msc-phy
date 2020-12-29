function [t, x, y, vx, vy] = problem_4()
%% Solves the equation of motions for a projectile with air drag

m=0.01; % the mass of the projectile in kg
g=9.8; % the acceleration due to gravity
c=0.1;
    function fvec = projectile_forces(x, y)
        % it is crucial to move from the ODE notation to the human notation 
        vx=y(1);
        vy=y(2);
        v=sqrt(vx^2+vy^2); % the speed value

        fvec(1) = -c*sqrt(vx^2 + vy^2)* vx;
        fvec(2) = - g -c*sqrt(vx^2 + vy^2) * vy;
        fvec=fvec.';
    end

tspan=[0, 10];


y0(1) = 20;
y0(2) = 0;%v0*cos(theta);


[t, ysol] = ode45(@projectile_forces, tspan, y0);

vx = ysol(:,1);
vy = ysol(:,2);
v  = sqrt(vx.^2 + vy.^2); 

hold on
plot(t, vx)
%plot(t, vy)

end