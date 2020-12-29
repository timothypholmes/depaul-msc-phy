function MyConvolution
%Code to solve Homework problems 
data = importdata('Vout.dat');
t = data(:,1);  %getting time
v = data(:,2); % getting voltage

%% response function
if t < 0
    roft = 0;
else
    roft = exp(-t);
end


%% FFT of response function and signal,using built in FFT
Froft = fft(roft);
Fv = fft(v);
ConSig = Fv./Froft;
Sig = ifft(ConSig);
plot(t,Sig)


end

