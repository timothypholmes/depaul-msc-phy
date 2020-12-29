%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Timothy Holmes
%       Wave Equation
% 0, 0, 10, 0.01, 1, 1, 1, 10s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function waveEquation(u0x,x0,xf,h,c,k,dx,t)

xl = int16((xf - x0)/(dx))+1; 
xp = linspace(x0,xf,xl);
u = zeros(1,xl); 
uj = zeros(1,xl); 
ujj = zeros(1,xl);

c = (((k^2)*(c^2))/(h^2));
c2 = (((k^2)*(c^2))/(2*(h^2)));

for jj = 2:(xl - 2) 
    u(jj) = u0x(double(jj)*dx);
end
for kk = 2:(xl - 1)
    uj(kk) = (c2*(u(kk+1) + u(kk-1))) + ((1 - c)*u(kk)); %+ k*((u(i,j+1) - u(i,j-1))/(2*k))));  
end

for j=0:t
    axis([0 1 -1 1]);
    ujj(2:end-1) = c*(uj(3:end)+uj(1:end-2))+2*(1-c)*uj(2:end-1)-u(2:end-1);
    pause(0.0000000001)
    plot(xp,u,'r');
    axis([0 1 -1 1]);
    u = uj;
    uj=ujj;
end
end


