
clear all
close all
taup = 0.4;
pri = 2;
n = 3;
bw = 50;

x = train_ambg_lfm(taup, n, pri, bw);

figure(1)
time = linspace(-(n-1)*pri-taup, n*pri-taup, size(x,2));
doppler = linspace(-bw,bw, size(x,1));
%mesh(time, doppler, x);
surf(time, doppler, x); shading interp;
xlabel('Delay - seconds');
ylabel('Doppler - Hz');
zlabel('Ambiguity function');
axis tight;

figure(2)
contour(time, doppler, (x));
%surf(time, doppler, x); shading interp; view(0,90);
xlabel('Delay - seconds');
ylabel('Doppler - Hz');
grid;
axis tight;
