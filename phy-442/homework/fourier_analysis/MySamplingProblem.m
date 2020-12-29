function MySamplingProblem(foft, t)
%Code to show the effects of sampling 

plot(t, foft)
title('Real function')
figure
j = 1;
for st = 1:8:length(t)
    A(j) = foft(st);
    plot(t(st), foft(st),'.k','MarkerSize',8)
    hold on
    j = j+1;
end
m =log2(j-1);
title('Sampling every second')
MySpec(A,m,t)
clear A
figure
j = 1;
for st = 1:4:length(t)
    A(j) = foft(st);
    plot(t(st),foft(st),'.k','MarkerSize',8)
    hold on
     j = j+1;
end
title('Sampling every half second')
m =log2(j-1);
MySpec(A,m,t)
clear A
figure
j = 1;
for st = 1:2:length(t)
    A(j) = foft(st);
    plot(t(st),foft(st),'.k','MarkerSize',8)
    hold on
    j = j + 1;
end
m = log2(j-1);
MySpec(A,m,t)
title('Sampling every quarter second')
end

