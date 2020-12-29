function csc_407_stats()

O3()
O2()
O0()

end


function O3()

fprintf("-O3 Optimization\n")

o3_alloc_sep_multi_loop  = [3.92664,2.12721,2.78327,1.77913,1.63215,1.61378,2.00892,2.56895,1.7433,1.64157 ];
o3_alloc_sep_single_loop = [4.02502, 4.05093 , 3.90751 , 3.96049 , 3.9063 , 3.9942 , 3.89468 , 3.90046 , 3.89145 , 4.06573]; 

o3_alloc_sep_multi_loop_avg   = mean(o3_alloc_sep_multi_loop(2:end));
o3_alloc_sep_single_loop_avg = mean(o3_alloc_sep_single_loop(2:end));

fprintf("Avg sep alloc multi loop: %s\n", o3_alloc_sep_multi_loop_avg)
fprintf("Avg sep alloc single loop: %s\n", o3_alloc_sep_single_loop_avg)

o3_alloc_same_multi_loop   = [3.47223, 1.86674, 1.55183, 1.55999, 1.616, 1.56173, 1.57933, 1.55029, 1.58675, 1.55581];
o3_alloc_same_single_loop = [3.92302, 3.95742, 3.91803, 3.90101, 3.91438, 3.90727, 3.90626, 3.87154, 3.99236, 3.91006];


o3_alloc_same_multi_loop_avg  = mean(o3_alloc_same_multi_loop(2:end));
o3_alloc_same_single_loop_avg = mean(o3_alloc_same_single_loop(2:end));

fprintf("Avg sep alloc multi loop: %s\n", o3_alloc_same_multi_loop_avg)
fprintf("Avg sep alloc single loop: %s\n", o3_alloc_same_single_loop_avg)


figure(1)
hold on;
title("-O3 Optimization Level Time Plot")
xlabel("Mutlple Loop Times (t)")
ylabel("Single Loop Times (t)")
plot(o3_alloc_sep_multi_loop(1), o3_alloc_sep_single_loop(1), 'ro', 'LineWidth', 1.2, 'MarkerSize', 7)
plot(o3_alloc_sep_multi_loop(2:end), o3_alloc_sep_single_loop(2:end), 'bo', 'LineWidth', 1.2, 'MarkerSize', 7)
plot(o3_alloc_same_multi_loop(1), o3_alloc_same_single_loop(1), 'mo', 'LineWidth', 1.2, 'MarkerSize', 7)
plot(o3_alloc_same_multi_loop(2:end), o3_alloc_same_single_loop(2:end), 'go', 'LineWidth', 1.2, 'MarkerSize', 7)

legend("Seperate Allocation First Run", "Seperate Allocation Nth Runs", ...
       "Same Allocation First Run", "Same Allocation Nth Runs") 
end


function O2()

fprintf("-O2 Optimization\n")

o2_alloc_sep_multi_loop  = [3.99547,1.93527,2.01029,1.55795,1.57062,1.5525,1.60105,1.67579,1.5544,1.64326];
o2_alloc_sep_single_loop = [4.09471,4.77364,3.9271,3.90503,3.87984,3.86236,4.08848,3.92734,3.97156,3.81268];

o2_alloc_sep_multi_loop_avg   = mean(o2_alloc_sep_multi_loop(2:end));
o2_alloc_sep_single_loop_avg = mean(o2_alloc_sep_single_loop(2:end));

fprintf("Avg sep alloc multi loop: %s\n", o2_alloc_sep_multi_loop_avg)
fprintf("Avg sep alloc single loop: %s\n", o2_alloc_sep_single_loop_avg)

o2_alloc_same_multi_loop  = [3.63343,1.80211,1.56846,1.6356,1.69211,1.54734,1.68877,1.55406,1.55431,1.54791];
o2_alloc_same_single_loop = [3.95149,3.96476,3.95356,4.06609,3.95902,4.15698,3.85362,3.8751,3.87115,3.90015];

o2_alloc_same_multi_loop_avg  = mean(o2_alloc_same_multi_loop(2:end));
o2_alloc_same_single_loop_avg = mean(o2_alloc_same_single_loop(2:end));


fprintf("Avg sep alloc multi loop: %s\n", o2_alloc_same_multi_loop_avg)
fprintf("Avg sep alloc single loop: %s\n", o2_alloc_same_single_loop_avg)


figure(2)
hold on;
title("-O2 Optimization Level Time Plot")
xlabel("Mutlple Loop Times (t)")
ylabel("Single Loop Times (t)")
plot(o2_alloc_sep_multi_loop(1), o2_alloc_sep_single_loop(1), 'ro', 'LineWidth', 1.2, 'MarkerSize', 7)
plot(o2_alloc_sep_multi_loop(2:end), o2_alloc_sep_single_loop(2:end), 'bo', 'LineWidth', 1.2, 'MarkerSize', 7)
plot(o2_alloc_same_multi_loop(1), o2_alloc_same_single_loop(1), 'mo', 'LineWidth', 1.2, 'MarkerSize', 7)
plot(o2_alloc_same_multi_loop(2:end), o2_alloc_same_single_loop(2:end), 'go', 'LineWidth', 1.2, 'MarkerSize', 7)

legend("Seperate Allocation First Run", "Seperate Allocation Nth Runs", ...
       "Same Allocation First Run", "Same Allocation Nth Runs") 

end


function O0()

fprintf("-O Optimization\n")

o_alloc_sep_multi_loop  = [3.95354,1.78887,1.82651,1.78463,1.8016,1.80597,1.81474,1.86465,1.83426,1.78932];
o_alloc_sep_single_loop = [4.13549,4.15057,4.181,4.21325,4.01407,4.1473,4.15337,4.14916,4.11903,4.11307];

o_alloc_sep_multi_loop_avg   = mean(o_alloc_sep_multi_loop(2:end));
o_alloc_sep_single_loop_avg = mean(o_alloc_sep_single_loop(2:end));

% for i = 1:length(o_alloc_sep_single_loop)
%    fprintf("[%f, %f, 0], ", o_alloc_sep_multi_loop(i), o_alloc_sep_single_loop(i)) 
% end

fprintf("Avg sep alloc multi loop: %s\n", o_alloc_sep_multi_loop_avg)
fprintf("Avg sep alloc single loop: %s\n", o_alloc_sep_single_loop_avg)

o_alloc_same_multi_loop  = [4.27868,1.88097,1.88995,1.80405,1.8081,2.39142,1.86423,1.81639,1.83605,2.57647];
o_alloc_same_single_loop = [3.69884,4.18803,4.06651,4.16252,4.47967,4.0157,4.23562,4.06599,4.13009,4.16253];

o_alloc_same_multi_loop_avg  = mean(o_alloc_same_multi_loop(2:end));
o_alloc_same_single_loop_avg = mean(o_alloc_same_single_loop(2:end));

% for i = 1:length(o_alloc_sep_single_loop)
%    fprintf("[%f, %f, 0], ", o_alloc_same_multi_loop(i), o_alloc_same_single_loop(i)) 
% end

fprintf("Avg sep alloc multi loop: %s\n", o_alloc_same_multi_loop_avg)
fprintf("Avg sep alloc single loop: %s\n", o_alloc_same_single_loop_avg)


figure(3)
hold on;
title("-O0 (Default) Optimization Level Time Plot")
xlabel("Mutlple Loop Times (t)")
ylabel("Single Loop Times (t)")
plot(o_alloc_sep_multi_loop(1), o_alloc_sep_single_loop(1), 'ro', 'LineWidth', 1.2, 'MarkerSize', 7)
plot(o_alloc_sep_multi_loop(2:end), o_alloc_sep_single_loop(2:end), 'bo', 'LineWidth', 1.2, 'MarkerSize', 7)
plot(o_alloc_same_multi_loop(1), o_alloc_same_single_loop(1), 'mo', 'LineWidth', 1.2, 'MarkerSize', 7)
plot(o_alloc_same_multi_loop(2:end), o_alloc_same_single_loop(2:end), 'go', 'LineWidth', 1.2, 'MarkerSize', 7)

legend("Seperate Allocation First Run", "Seperate Allocation Nth Runs", ...
       "Same Allocation First Run", "Same Allocation Nth Runs") 

end