function MyAutoCorrelation
%
delta = 0.05;
len = 200;
t=0;
datlen = 50/0.05;
%%
% generating data
for n = 1:datlen
    t = t + delta;
    %p(n) = sin(t) + 4.0 *rand;
    p(n) = t^(2 + rand);
    if t <= 20                      % limit to 20 for no reason.
        plot(t,p(n),'.k','MarkerSize',8)
        hold on
    end
end
%%
% calculating correlation
%%
figure
lstpt = length(p) - len -1;
for dtau = 1: lstpt
    lag = dtau*delta;
    sum = 0.0;
    for m = 1:len + 1
        sum = sum + p(m)*p(m+dtau)*delta; % simple trapezoid rule to calculate integral
    end
    T = len*delta;
    autocorr(dtau) = sum/T;
    if lag <= 20
    plot(lag,autocorr(dtau),'.b','MarkerSize',8)
    ylim([0 6.5]);
    hold on
    end
end
%%
end

