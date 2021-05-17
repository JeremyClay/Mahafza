% Use this program to reproduce Fig. 5.10 of the textbook.
clear all
close all
taup = 0.4;
pri = 1;
n = 3;
bw = 10;
x = train_ambg_lfm(taup, n, pri, bw);
figure(1)
time = linspace(-(n-1)*pri-taup, n*pri-taup, size(x,2));
doppler = linspace(-bw,bw, size(x,1));
%mesh(time, doppler, x);
surf(time, doppler, x); shading interp;
xlabel('Delay in seconds');
ylabel('Doppler in Hz');
zlabel('Ambiguity function');
axis tight;
title('LFM pulse train, B\tau = 40, N = 3 pulses')
figure(2)
contour(time, doppler, (x));
%surf(time, doppler, x); shading interp; view(0,90);
xlabel('Delay in seconds');
ylabel('Doppler in Hz');
grid;
axis tight;
title('LFM pulse train, B\tau = 40, N = 3 pulses')
