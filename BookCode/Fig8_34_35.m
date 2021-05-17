% this program reproduces Figs 8.34 and 8.35 of text book
clc
clear all
close all
format long
h_ft = [0 2500 5000 10000 20000 30000 40000 60000 80000];
height = 0.3048 .* h_ft ;
Wvd = [6.18 4.93 3.74 2.01 0.34 0.05 .009 eps eps];
figure(1)
freq = 500e6;
beta = .0;
[gammaO2, gammaH2O,range] = absorption_range(height,Wvd, freq,beta);
[Attn rangei1] = atmospheric_attn(gammaO2,gammaH2O,range);
M = size(Attn,2);
plot(rangei1,Attn,'c', 'linewidth',1)
hold on
beta = 0.5;
[gammaO2, gammaH2O,range] = absorption_range(height,Wvd, freq,beta);
[Attn rangei] = atmospheric_attn(gammaO2,gammaH2O,range);
Attn (end:M) = Attn(end);
plot(rangei1,Attn,'b','linewidth',1)
hold on
beta = 1.0;
[gammaO2, gammaH2O,range] = absorption_range(height,Wvd, freq,beta);
[Attn rangei] = atmospheric_attn(gammaO2,gammaH2O,range);
Attn (end:M) = Attn(end);
plot(rangei1,Attn,'m', 'linewidth',1)
hold on
beta = 2;
[gammaO2, gammaH2O,range] = absorption_range(height,Wvd, freq,beta);
[Attn rangei] = atmospheric_attn(gammaO2,gammaH2O,range);
Attn (end:M) = Attn(end);
plot(rangei1,Attn,'k', 'linewidth',1)
hold on
beta = 5;
[gammaO2, gammaH2O,range] = absorption_range(height,Wvd, freq,beta);
[Attn rangei] = atmospheric_attn(gammaO2,gammaH2O,range);
Attn (end:M) = Attn(end);
plot(rangei1,Attn,'g', 'linewidth',1)
hold on
beta = 10;
[gammaO2, gammaH2O,range] = absorption_range(height,Wvd, freq,beta);
[Attn rangei] = atmospheric_attn(gammaO2,gammaH2O,range);
Attn (end:M) = Attn(end);
plot(rangei1,Attn,'r')
hold off
legend('\beta=0.0','\beta=0.5','\beta=1.0','\beta=2.','\beta=5.0','\beta=10.0')
xlabel('Radar to target range - Km')
ylabel('2-way atmospheric attenuation - dB')
title('frequency = 500MHz')
axis tight
grid on



   
    
