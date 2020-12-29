function MySpecAnalysis

row = 6147;            % size of data
col = 2;
%id = fopen('tuning_fork.dat','r'); % opening file
id = fopen('powerlaw.dat','r'); % opening file
info = fgetl(id);		% reading first line which contains text
info2 = fgetl(id);		% reading second line which contains text
% row = 2048;
% col = 2;
% id = fopen('first_spectra.dat','r');
data = fscanf(id,'%f %f',[col,row]); % now reading data
data = data';			% data stored in wrong format
t = data(:,1);
A = data(:,2);
m = floor(log2(length(A)));
fclose(id);
F = MyFFT(A,m);
fs = abs(1/(t(2) -t(1)));

% f = fs/2*linspace(0,1,2^m/2 + 1); % frequency
f = pi*fs*linspace(0,1,2^m/2 + 1);
plot(f(2:end),abs(F(2:2^m/2 +1)))%,'.k','MarkerSize',8)
end
function [A] = MyFFT(A,m) 

% This function performs the Fast Fourier Transform by Recursion. 
%  
% The array A contains the complex data to be transformed and 'm' is 
% log2(N).
%  

N = 2^m; 
Nd2 = N/2; 
if(N==1) 
     A = A; % don't need to do anything 
else 
    even = zeros(1,Nd2); % Data 
    odd  = zeros(1,Nd2); % Data 

    for k = 1:Nd2 
        even(k) = A(k+k-1); 
        odd(k)  = A(k+k ); 
    end 
%     even
%     odd
%     pause
    q = zeros(1,Nd2); % Data 
    r = zeros(1,Nd2); % Data 

    q = MyFFT(even, m-1); 
    r = MyFFT( odd, m-1);

    for k = 1:Nd2 
        ang = -2*(k-1)*pi/N; 
        ck  = complex(cos(ang), sin(ang)); 
        A(  k  ) = q(k)+ck*r(k);
        A(k+Nd2) = q(k)-ck*r(k);
   
    end 
end 

end
