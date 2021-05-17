% this program reproduces Figs 8.33 
clc
clear all
close all
format long
h_ft = [0 2500 5000 10000 20000 30000 40000 60000 80000];
height = 0.3048 .* h_ft ;
Wvd = [6.18 4.93 3.74 2.01 0.34 0.05 .009 eps eps];
freq = 300e6;
beta = .0;
[gammaO2, gammaH2O,range] = absorption_range(height,Wvd, freq,beta);
Akm1 = gammaO2 + gammaH2O;
xx = 0:.1:range(end);
yy1 = spline(range,Akm1,xx);
freq = 1e9; 
[gammaO2, gammaH2O,range] = absorption_range(height,Wvd, freq,beta);
Akm2 = gammaO2 + gammaH2O;
yy2 = spline(range,Akm2,xx);
figure
height = height ./1000;
subplot(1,2,1)
plot(xx,yy1,'k','linewidth',1)
grid
legend('300MHz')
ylabel('Atmospheric absorption per Km - dB')
xlabel('Radar down range - Km')
subplot(1,2,2)
plot(range,Akm2,'k','linewidth',1)
grid
legend('1GHz')
ylabel('Atmospheric absorption per Km - dB')
xlabel('Radar down range - Km')

