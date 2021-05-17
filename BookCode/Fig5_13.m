% figure 5.10
clear all
close all
taup = 0.4;
pri = 1;
n = 3;
bw = 50;
bi = 50;
x = train_ambg_SFW(taup, n, pri, bw,bi);
figure(1)
time = linspace(-(n-1)*pri-taup, n*pri-taup, size(x,2));
doppler = linspace(-(bw+(n-1)*bi),(bw+(n-1)*bi), size(x,1));
%mesh(time, doppler, x);
surf(time, doppler, x); shading interp;
xlabel('Delay - seconds');
ylabel('Doppler - Hz');
zlabel('Ambiguity function');
axis tight;
title('LFM pulse train, B\tau = 40, N = 3 pulses')
figure(2)
contour(time, doppler, (x));
%surf(time, doppler, x); shading interp; view(0,90);
xlabel('Delay - seconds');
ylabel('Doppler - Hz');
grid;
axis tight;
%title('LFM pulse train, B\tau = 40, N = 3 pulses')
