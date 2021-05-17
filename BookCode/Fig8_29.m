% generates Figure 8.29 of text
clc
clear all
close all
freq =428e6;
hr = 3000; 
ht = 200;
R = linspace(205e3,350e3,200); % range in Km
nt =1500; % number of point used in calculting infinite series
F = diffraction(freq, hr, ht,R,nt);
figure(1)
plot(R/1000,10*log10(abs(F).^2),'k','linewidth',1)
grid 
xlabel('\bfRange in Km')
ylabel('\bfOne way propagation factor in dB')
title('\bffrequency = 428 MHz; hr = 3000 m; ht = 2000 m')