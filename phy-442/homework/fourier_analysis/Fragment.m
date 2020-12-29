%*  This is a code fragment ONLY.                                                     *
clear;
%  Read the data from the given input file

fid  = fopen('Vout.dat','r');
...

%
%  After choosing an appropriate range in time and omega, fill the arrays ...
%

for i=???
    
    t = 
    Vout = 
end

figure('Name','Original Data: Vout');  % Plot the original output data
plot(t, Vout);

N      =  
deltaT =                      % determined by range in omega
T      =  N * deltaT;         % Range in T

%  Calculate the "known" response function, r(t)...

alpha = 1.0;		    % alpha = 1/RC...
r     = exp(-alpha*t);
r(1)  = 0.5;                % Always best to set to the mean at a discontinuity

%  The FFT of response function

FR = 

% Now, evaluate Vin by deconvolution!!!

...


% Plot the calculated input signal

...
