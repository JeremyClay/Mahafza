% Use this code to generate Fig. 9.10 of text
clc
clear all
close all
k = 1.38e-23; % Boltzman’s constant
pt = 45e3;
theta_AZ = 1.5;
theta_EL = 2;
F = 6;
L = 10;
tau = 1e-6;
B = 1/tau;
sigmmat = -10;
sigmma0 = -20;
SL = -25;
hr = 3;
ht = 150;
f0 = 5e9;
lambda = 3e8/f0;
range = linspace(2,45, 120);
[sigmmaC] = clutter_rcs(sigmma0, theta_EL, theta_AZ, SL, range, hr, ht, B,2);
sigmmaC = 10.^(sigmmaC./10);
range_m = 1000 .* range;
F = 10.^(F/10); % noise figure is 6 dB
T0 = 290; % noise temperature 290K
g = 26000 /theta_AZ /theta_EL; % antenna gain
Lt = 10.^(L/10); % total radar losses 13 dB
sigmmat = 10^(sigmmat/10)
CNR = pt*g*g*lambda^2 .* sigmmaC ./ ((4*pi)^3 .* (range_m).^4 .* k*T0*F*Lt*B); % CNR
SNR = pt*g*g*lambda^2 .* sigmmat ./ ((4*pi)^3 .* (range_m).^4 .* k*T0*F*L*B); % SNR
SCR = SNR ./ CNR; % Signal to clutter ratio
SIR = SNR ./ (1+CNR); % Signal to interference ratio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
subplot(3,1,1)  
plot(range,10*log10(SNR),'linewidth',1.5);
ylabel('\bfSNR in dB'); grid on;axis tight
subplot(3,1,2) 
plot(range,10*log10(CNR),'linewidth',1.5);
ylabel('\bfCNR in dB');grid on;axis tight
subplot(3,1,3)
plot(range,10*log10(SCR),'linewidth',1.5);
ylabel('\bfSCR in dB') ;grid on;axis tight
xlabel('\bfRange in Km')
