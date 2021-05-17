% generates Fig 10.23 of text
clc
close all; 
clear all;
fc = 500;
f  = linspace(350,650, 300);
c1  = 2*1e-5; 
fc1 = c1*pi*fc^2; 
L1f = 1/pi*fc1./(fc1^2 + (f-fc).^2);
c2  = 0.5*1e-5; 
fc2 = c2*pi*fc^2; 
L2f = 1/pi*fc2./(fc2^2 + (f-fc).^2);
plot(f,L1f,'ro-','linewidth',1.); 
hold on;
plot(f,L2f,'bd-','linewidth',1.); 
xlabel('\bfFrequency - Hz'); 
ylabel('\bfL(f), ratio of noise power to carrier power');
axis([300 700 0 0.09]); 
title('\bf fc=500Hz')
grid on;
legend('cp=2e-5','cp=0.5*1e-5'); 
