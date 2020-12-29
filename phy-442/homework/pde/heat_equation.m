function heat_equation(A,B,x0,xf,t0,tf,h,k,a)
%initial conditions
%100,0,0, pi, 0, 1, 0.1,0.01,0.5
%@(x,t,z)sin(x*pi),0,0, pi, 0, 1, 0.1,0.01,0.5
%@(x,t,z)sin(x*pi)),0,0, pi, 0, 1, 0.1,0.01,0.5
xl = int16(((xf - x0)/(h))+1); 
tl = int16(((tf - t0)/(k))+1);
u = zeros(xl,tl); 
s = ((a^2)*k)/(h^2);%Constants
tic

%% Iterations
for j = 2:1:(tl - 1) 
    u(1,:) = A(double(j)*h,double(j)*k,double(j)*h*k);
    u(:,1) = B;
    for i = 2:1:(xl - 1) 
        u(i,j) = ((1-2*s)*u(i,j-1)) + (s*(u(i+1,j-1)+u(i-1,j-1))); 
    end
end
toc
u = u';

%% graph
figure(1)
[x,y] = meshgrid(x0:h:xf,t0:k:tf);
surf(x,y,u);
mesh(x,y,u);
xlabel('Position');
ylabel('Time');
zlabel('Temperature');

%% View
view(300,20)        
camzoom(1.2)        

%% Record
viobj = VideoWriter('heatEquation.avi');
open(viobj);
for k = 1:250
   camorbit(1,0,'data',[0 0 1])
   drawnow
   currFrame = getframe;
   writeVideo(viobj,currFrame); 
end
close(viobj);
end

function input_data
%initial conditions
%100,0,0, pi, 0, 1, 0.1,0.01,0.5
%@(x,t,z)sin(x*pi),0,0, pi, 0, 1, 0.1,0.01,0.5
%@(x,t,z)sin(x*pi)),0,0, pi, 0, 1, 0.1,0.01,0.5

A  =
B  =
x0 =
xf =
t0 =
tf =
h  =
k  =
a  =

end