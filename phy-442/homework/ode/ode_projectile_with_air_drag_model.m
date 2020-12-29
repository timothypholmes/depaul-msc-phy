function [t, x, y, vx, vy] = ode_projectile_with_air_drag_model()
%% Solves the equation of motions for a projectile with air drag

m=0.01; % the mass of the projectile in kg
g=9.8; % the acceleration due to gravity
c=0.1;
    function fvec = projectile_forces(x, y)
        % it is crucial to move from the ODE notation to the human notation 
        vx=y(2);
        vy=y(4);
        v=sqrt(vx^2+vy^2); % the speed value

        fvec(1) = y(2); 
        fvec(2) = -c*sqrt(vx^2 + vy^2)* vx;
        fvec(3) = y(4);
        fvec(4) = -g - c*sqrt(vx^2 + vy^2) * vy;
        fvec=fvec.';
    end

tspan=[0, 10];


y0(1)=0;
y0(2)=20;%v0*cos(theta);
y0(3)=0;
y0(4)=0;%v0*sin(theta);

[t, ysol] = ode45(@projectile_forces, tspan, y0);

x =  ysol(:,1);
vx = ysol(:,2);
y =  ysol(:,3);
vy = ysol(:,4);
v=sqrt(vx.^2+vy.^2); 

hold on
plot(x, y)
% plot(t, x)
% plot(t, vx)
% plot(t, y)
% plot(t, vy)
% xlabel('t');
% ylabel('[x, v_{x}, y, v_{y}]');
% legend('x', 'v_{x}', 'y', 'v_{y}')

end