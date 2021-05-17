% generates Fig 10.24 of text
clc
close all
clear all;
fc = 500; 
f  = [0.01:.01:100];
fb = pi/2;
Lf = 1/pi*fb./(fb^2 + (f-fc+fc).^2);
semilogx((f),10*log10(Lf),'b','linewidth',1.5);
xlabel('\bfFrequency - Hz'); 
ylabel('\bfRatio of noise power to carrier power - dBc/Hz');
title('f_b = \pi/2')
axis([0.01 100 -50 10]); grid on;



