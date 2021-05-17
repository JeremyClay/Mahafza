% Use this program to reproduce Fig. 5.8 of text
clear all
close all
taup = .4;
pri = 1;
n = 5;
x = train_ambg(taup, n, pri);
figure(1)
time = linspace(-(n-1)*pri-taup, n*pri-taup, size(x,2));
doppler = linspace(-1/taup, 1/taup, size(x,1));
%mesh(time, doppler, x);
mesh(time, doppler, x); %shading interp;
xlabel('Delay in seconds');
ylabel('Doppler in Hz');
zlabel('Ambiguity function');
axis tight;
figure(2)
contour(time, doppler, (x));
%surf(time, doppler, x); shading interp; view(0,90);
xlabel('Delay in seconds');
ylabel('Doppler in Hz');
grid;
axis tight;
