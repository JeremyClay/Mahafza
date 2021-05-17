% generates Fig 8.36 of text
clc
clear all
close all
format long
alpha = 0.0002;
beta = 2.25;
freq = [1 5 10];
f = freq.^beta;
r = linspace(0,100,1000); % rai fall rate i mm/hr
Att1 = (alpha * f(1) .* r);
Att2 = (alpha * f(2) .* r);
Att3 = (alpha * f(3) .* r);
figure(1)
semilogy(r,Att3, 'k:',r,Att2,'k-.',r,Att1,'k','linewidth',1.5)
xlabel('\bf Rain rate mm/hr')
ylabel('\bfone-way rain attenuation dB/Km')
grid on
legend('freq = 10Ghz','freq = 5GHz','freq = 1GHz')
