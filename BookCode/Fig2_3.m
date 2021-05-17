% Use this program to reproduce Fig. 2.3 of text.
close all
clear all
pt = 10e03; % peak power in Watts
freq = 5.6e+9; % radar operating frequency in Hz
g = 20; % antenna gain in dB
sigma = 0.01; % radar cross section in m squared
b = 5.0e+6; % radar operating bandwidth in Hz
nf = 3.0; %noise figure in dB
loss = 8.0; % radar losses in dB
Ti = 2; % time on target in seconds
dt = .05; % 5% duty cycle
range = linspace(10e3,225e3,1000); % range to target from 10 Km 225 Km, 1000 points
snr1 = hprf_req (pt, Ti, g, freq, sigma, .05, range, nf, loss);
snr2 = hprf_req (pt, Ti, g, freq, sigma, .1, range, nf, loss);
snr3 = hprf_req (pt, Ti, g, freq, sigma, .2, range, nf, loss);
% plot SNR versus range
figure(1)
rangekm  = range ./ 1000;
plot(rangekm,snr3,'k',rangekm,snr2,'k -.',rangekm,snr1,'k:','linewidth',1.5)
grid
legend('dt = 20%','dt = 10%','dt = 5%')
xlabel ('Detection range - Km');
ylabel ('SNR - dB');




