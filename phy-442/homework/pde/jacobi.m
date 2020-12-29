%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Timothy Holmes
%       Jacobi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [uu] = jacobi(xl,xr,A,B,dx,tol)
%inital
%0,1,10,10,0.1,0.001
N = (1/dx);

u = zeros(N,1) ;
uu = ones(N,1) ;

u(1)=A ; uu(1)=A ;
u(N)=B ; uu(N)=B ;

sigma = tol + 1 ;
sigmaP = tol + 1 ;

tic
while (sigma > tol) && (sigmaP > tol)
    
    for i = 2:(N-1)
    
    uu(i) =( u(i-1) + u(i+1) )/2 ;
    
    
    end
    
    sigma = abs( norm(uu - u) ) ;
    sigmaP = sigma./norm(uu) ; 
   
    u = uu ;
%%%%%%%%%%graph%%%%%%%%%%
%pause(0.001)
dis = linspace(xl,xr,N);
plot(dis,uu);
xlabel('x')
ylabel('y') 
end
toc
end


