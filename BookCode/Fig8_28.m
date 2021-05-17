% this program generates Fig. 8.28 of text
clc
clear all
close all
freq =167e6;
hr = 8000; 
ht = 1000;
R = linspace(400e3,600e3,200); % range in Km
nt =1500; % number of point used in calculting infinite series
F = diffraction(freq, hr, ht,R,nt);
figure(1)
plot(R/1000,10*log10(abs(F).^2),'k','linewidth',1)
grid 
xlabel('\bfRange in Km')
ylabel('\bfOne way propagation factor in dB')
title('\bffrequency = 167 MHz; hr = 8000 m; ht = 1000 m')