% Use this program to reproduce Fig. 5.2 of text
close all
clear all
eps = 0.000001;
taup = 3;
[x] = single_pulse_ambg (taup);
taux = linspace(-taup,taup, size(x,1));
fdy = linspace(-5/taup+eps,5/taup-eps, size(x,1));
figure(1)
mesh(taux,fdy,x);
xlabel ('Delay in seconds')
ylabel ('Doppler in Hz')
zlabel ('Ambiguity function')
figure(2)
contour(taux,fdy,x);
xlabel ('Delay in seconds')
ylabel ('Doppler in Hz')
grid
