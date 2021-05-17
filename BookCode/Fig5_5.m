% Use this program to reproduce Fig. 5.5 of text
close all
clear all
eps = 0.0001;
taup = 1.;
b = 5.;
up_down = -1.;
x = lfm_ambg(taup, b, up_down);
taux = linspace(-1.*taup,taup,size(x,1));
fdy = linspace(-1.5*b,1.5*b,size(x,1));
figure(1)
mesh(taux,fdy,sqrt(x))
xlabel ('Delay in seconds')
ylabel ('Doppler in Hz')
zlabel ('Ambiguity function')
axis tight
figure(2)
contour(taux,fdy,sqrt(x))
xlabel ('Delay in seconds')
ylabel ('Doppler in Hz')
grid
