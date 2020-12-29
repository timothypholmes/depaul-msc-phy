%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Timothy Holmes
%       Heat Equation 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function heatEquation(A,B,x0,xf,t0,tf,h,k,a)
%initial conditions
%a) 100,0,0, pi, 0, 1, 0.1,0.01,0.5
%b) @(x)sin(x*pi),0,0, pi, 0, 1, 0.1,0.01,0.5
xl = int16(((xf - x0)/(h))+1); 
tl = int16(((tf - t0)/(k))+1);
u = zeros(xl,tl); 

%u(1,:) = A; %100 % remove % for initial condition a)
u(:,1) = B; %0

s = ((a.^2)*k)./(h.^2);%Constants
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%Iterations%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j = 2:1:(tl - 1) 
    u(1,:) = A(double(j)*k);% remove % for initial condition b)
    for i = 2:1:(xl - 1) 
        u(i,j) = ((1-(2*s))*u(i,j-1)) + (s*(u(i+1,j-1)+u(i-1,j-1))); 
    end
end
toc
u = u';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%graph%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
%pause(0.001)
figure(1)
[x,y] = meshgrid(x0:h:xf,t0:k:tf);
surf(x,y,u);
mesh(x,y,u);
xlabel('Position');
ylabel('Time');
zlabel('Temperature');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%View%%%%%%%%%%%%%%%%%%%%%%%%%%%%
view(300,20)        
camzoom(1.2)        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%Record Video%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% viobj = VideoWriter('heatEquation.avi');
% open(viobj);
% for k = 1:250
%    camorbit(1,0,'data',[0 0 1])
%    drawnow
%    currFrame = getframe;
%    writeVideo(viobj,currFrame); 
% end
% close(viobj);
hold off
 end

