function fourier_series(t0, tf, step, nmax)
%% Fourier Series

if (~exist('t0', 'var')) && (~exist('tf', 'var')) && ...
   (~exist('step', 'var')) && (~exist('nmax', 'var'))
    [t0, tf, step, nmax] = sample_data();
end

a = 10;

for t = t0:step:tf
    if t < 0
        f_of_t = -1;
    elseif t > 0
        f_of_t = 1;
    end
    
    for n = 1:2:nmax
        f_of_t = f_of_t - 4/(n * pi) * sin(n * t);
    end   
    
    figure(1)
    title(['Fourier Series: N = ' num2str(nmax)]);
    plot(t, f_of_t, 'b.', 'MarkerSize', 8)
    xlabel('t')
    ylabel('f(t)')
    hold on
    
end

end


function [t0, tf, step, nmax] = sample_data()

t0   = -pi;
tf   = pi;
step = pi/16; 
nmax = 10;

end