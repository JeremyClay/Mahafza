% Generates Figure 3.6 of text
close all
clear all
LFM_BW = 15e6;
tau = 1e-6;
ts = 1e-9; % 1000 samples per PW
beta = LFM_BW/tau;
t = 0: ts: +tau;
S = exp(j*pi*beta*(t.^2));
figure
subplot(2,1,1), plot(t*1e6,imag(S),'linewidth',1.5), grid
ylabel('Up-chirp LFM')
% The matched filter for S(t) is S*(-t)
t = -tau: ts: 0;
Smf = exp(-j*pi*beta*(t.^2));
subplot(2,1,2), plot(t*1e6,imag(Smf),'linewidth',1.5), grid
xlabel('time in microseconds')
ylabel('Down-chirp LFM')


