%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Timothy Holmes
%       Gauss Seidel Equation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [u] = gaussSeidel(u0x,ufx,x0,xf,u0y,ufy,y0,yf,dx,dy,tol)
%inital conditions
%0,100,0,10,0,100,0,10,0.5,0.5,0.001
M = ((xf - x0)/dx) + 1;
N = ((yf - y0)/dy) + 1;
u = zeros(M,N) ;

u(1,:) = u0y; u(N,:) = ufy;
u(:,1) = u0x; u(:,M) = ufx;

sigma = tol + 1 ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%Iterations%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
while (sigma > tol) 
    
    for i = 2:(N-1)
        
        for j = 2:(N-1)
            
            uu = u(i,j);
            u(i,j) = ( u(i-1,j) + u(i+1,j) + u(i,j-1) + u(i,j+1))/4 ; 
            
        end
        
    end
    
    sigma = abs((u(i,j)-uu)/((u(i,j)+uu)/2));
    
end
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%graph%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
figure(1)
[x,y] = meshgrid(x0:dx:xf,y0:dy:yf);
surf(x,y,u);
mesh(x,y,u);
xlabel('x');
ylabel('y');
zlabel('u(x,y)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%View%%%%%%%%%%%%%%%%%%%%%%%%%%%%
view(-40,30)       
camzoom(0.9)     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%Record%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% viobj = VideoWriter('gaussSiedel.avi');
% open(viobj);
% for k = 1:500
%    camorbit(1,0,'data',[0 0 1])
%    drawnow
%    currFrame = getframe;
%    writeVideo(viobj,currFrame); 
% end
% close(viobj);
% hold off
end