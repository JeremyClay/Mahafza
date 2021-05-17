% Use this program to reproduce Fig. 2.1 of text.
close all
clear all
pt = 1.5e+6; % peak power in Watts
freq = 5.6e+9; % radar operating frequency in Hz
g = 45.0; % antenna gain in dB
sigma = 0.1; % radar cross section in m squared
b = 5.0e+6; % radar operating bandwidth in Hz
nf = 3.0; % noise figure in dB
loss = 6.0; % radar losses in dB
range = linspace(25e3,165e3,1000); % range to target from 25 Km 165 Km, 1000 points
snr1 = radar_eq(pt, freq, g, sigma, b, nf, loss, range);
snr2 = radar_eq(pt, freq, g, sigma/10, b, nf, loss, range);
snr3 = radar_eq(pt, freq, g, sigma*10, b, nf, loss, range);
% plot SNR versus range
figure(1)
rangekm  = range ./ 1000;
plot(rangekm,snr3,'k',rangekm,snr1,'k -.',rangekm,snr2,'k:','linewidth',1.5)
grid
legend('\sigma = 0 dBsm','\sigma = -10dBsm','\sigma = -20 dBsm')
xlabel ('Detection range - Km');
ylabel ('SNR - dB');
snr1 = radar_eq(pt, freq, g, sigma, b, nf, loss, range);
snr2 = radar_eq(pt*.4, freq, g, sigma, b, nf, loss, range);
snr3 = radar_eq(pt*1.8, freq, g, sigma, b, nf, loss, range);
figure (2)
plot(rangekm,snr3,'k',rangekm,snr1,'k -.',rangekm,snr2,'k:','linewidth',1.5)
grid
legend('P_t = 2.16 MW','P_t = 1.5 MW','P_t = 0.6 MW')
xlabel ('Detection range - Km');
ylabel ('SNR - dB');




