%Use this program to reproduce Fig. 15.51 of text
clear all
close all
d = 0.6; % element spacing in lambda units
betadeg = linspace(0,22.5,1000);
beta = betadeg .*pi ./180;
den = pi*d .* sin(beta);
numarg = den;
num = sin(numarg);
lscan = (num./den).^-4;
LSCAN = 10*log10(lscan+eps);
figure (1)
plot(betadeg,LSCAN,'linewidth',1.5)
xlabel('\bfscan angle in degrees')
ylabel('\bfScan loss in dB')
grid
title('Element spacing is d = 0.6 \lambda ')