function homework_5()

    fprintf('Enter an integer for what problem you want to run 1-8\n')
    prompt = input('What problem do you want to run? \n problem: ');


    if prompt == 1
        problem_1()

    elseif prompt == 2
        problem_2()

    elseif prompt == 3
        problem_3()

    elseif prompt == 4
        problem_4()

    elseif prompt == 5
        problem_5()

    elseif prompt == 6
        problem_6()

    elseif prompt == 7
        problem_7()

    elseif prompt == 8
        problem_8()

    end

end

function problem_1()

    t0   = -pi;
    tf   = pi;
    step = pi/16; 
    nmax = [10, 20, 30, 40, 50];

    for i = 1:length(nmax)
        fourier_series(t0, tf, step, nmax(i))
        pause()
        clf;
    end

    close;

end

function problem_2()

    a = 10;
    T = 2/a;
    N = 5000;
    n = linspace(-100, 100, N);
    omega = n * pi/T;
    g_w = zeros(N, 1);

    for j = 1:N

        f_t = @(t, a) (a * (1 - a * abs(t)));

        g_w(j) = 1/sqrt(2 * pi) * integral(@(t) f_t(t, a) ...
                 .* exp(-1 * 1i * omega(j) * t), -1/a, 1/a, ... 
                 'RelTol', 0, 'AbsTol', 1e-5);
    end

    figure(1)
    hold on
    title('Numerical Fourier Transform')
    plot(omega, abs(g_w), 'b')
    xlabel('w')
    ylabel('g(w)')

end

function problem_3()

    N = 100;
    a = 10;
    t = linspace(-1/a, 1/a, N);
    omega = 1./t;
    f_t = (a * (1 - a * abs(t)));

    g_w = zeros(N,1);
    for n = 0:N - 1
        g_w(n + 1) = 0;
        for m = 0:N - 1
            g_w(n + 1) = g_w(n + 1) + (f_t(m + 1) * exp((-1i * 2 * pi * m * n)/N));
        end
    end

    figure(1)
    hold on
    title('Discrete Fourier Transform')
    plot(omega(2:end), abs(g_w(2:end)), 'b.')
    xlabel('w')
    ylabel('g(w)')

end

function problem_4()

    N = 128;
    a = 10;
    t = linspace(-1/a, 1/a, N);
    omega = 1./t;
    f_t = (a * (1 - a * abs(t)));

    m = 7; % N = 2^m = 128
    A = fast_fourier_transform(f_t, m);

    figure(1)
    hold on
    title('Fast Fourier Transform')
    plot(omega(2:end), abs(A(2:end)), 'b.')

end

function problem_5()

    N   = 32;%[32, 64, 128];
    t   = linspace(0, N, 8 * N);
    f_t = cos(6 * pi * t);

    MySamplingProblem(f_t, t)

end

function problem_6()

    alpha = 0.8;%0:0.01:1;
    N     = 32;%[32, 64, 128];
    t     = linspace(0, N, 8*N);
    f_t   = (sin(2 + alpha)*t) + (sin(4 - alpha)*t);
    
    %plot(t, f_t)
    
    MySamplingProblem(f_t, t)

end

function problem_7()

    data = readtable('Vout.dat');
    m = 11;%floor(log2(length(data.Var1)));
    N = length(data.Var1);
    t = data.Var1;
    R = 1;
    C = 1;

    f_v_out = fft(data.Var2);
    r_t = zeros(N, 1);
    % for i = 1:N
    %     if t(i) < 0
    %         r_t(i) = 0;
    %     else
    %         r_t(i) = 1/(R * C) * exp(-t(i)/(R * C));
    %     end
    % end
    alpha = 1.0;		    % alpha = 1/RC...
    r_t     = exp(-alpha * t);
    r_t(1)  = 0.5;                % Always best to set to the mean at a discontinuity

    f_r_t = fft(r_t);

    a = f_v_out./f_r_t;

    v_in = ifft(a);
    omega = 1./t;
    


    hold on
    title('Simple RC Circuit')
    plot(omega(7:N-10), abs(v_in(7:N-10)), 'b-')
    plot(omega(7:N-10), abs(v_in(7:N-10)), 'r.')
    xlabel('\omega')
    ylabel('v_{in}(t)')

end

function problem_8()

    data = readtable('tuning_fork.dat');

    t     = data.seconds;
    volts = data.volts;
    m = floor(log2(length(volts)));
    F = fast_fourier_transform(volts, m);
    fs = abs(1/(t(2) - t(1)));

    freq = pi * fs * linspace(0, 1, (2^m/2 + 1));

    [maxy frequency] = max(abs(F(2:2^m/2 + 1)));
    frequency = freq(frequency);

    figure(1)
    hold on
    title('Frequency of a Tuning Fork')
    plot(freq(2:end), abs(F(2:2^m/2 +1)))
    plot(frequency, maxy, 'rx')
    text((frequency + 200), maxy, ['\leftarrow Frequency: ', num2str(frequency)])
    xlabel('\omega')
    ylabel('|g(\omega)|')

end















