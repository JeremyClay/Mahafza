% generates Fig. 14.19 of text
clc
close all
clear all
r1 = .125;
r2 = 0.05;
h = 1;
phi = 45;
freq = 5.6e9;
freqGH = num2str(freq*1.e-9);
% Fig 14.19a
[rcs1] = rcs_cylinder(r1, r1, h, freq, phi,'Circular');
figure(1)
angle = linspace(0,180,size(rcs1,2));
plot(angle,10*log10(rcs1),'k','linewidth',1.5);
grid on;
xlabel ('\bfAspect angle in dDegrees');
ylabel ('\bfRCS - dBsm');
title  (['Circular Cylinder at Frequency = ',[freqGH],'  GHz']); 
% Fig. 14.19b
[rcs2] = rcs_cylinder(r1, r2, h, freq, phi,'Elliptic');
figure(2)
angle = linspace(0,180,size(rcs2,2));
plot(angle,10*log10(rcs2),'k','linewidth',1.5);
grid on;
xlabel ('\bfAspect angle in degrees');;
ylabel ('\bfRCS - dBsm');
title  (['Elliptic Cylinder at Frequency = ',[freqGH],'  GHz']);