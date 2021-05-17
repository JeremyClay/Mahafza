% this program reproduces Fig 8.31 of text book
clc
clear all
close all
format long
h_ft = [0 2500 5000 10000 20000 30000 40000 60000 80000];
height = 0.3048 .* h_ft ;
Wvd = [6.18 4.93 3.74 2.01 0.34 0.05 .009 eps eps];
freq = 300e6;
[gammaO21, gammaH2O1] = atmo_absorp(height,Wvd, freq);
gamma1 = gammaO21 + gammaH2O1;
freq = 500e6;
[gammaO22, gammaH2O2] = atmo_absorp(height,Wvd, freq);
gamma2 = gammaO22 + gammaH2O2;
freq = 1e9;
[gammaO23, gammaH2O3] = atmo_absorp(height,Wvd, freq);
gamma3 = gammaO23 + gammaH2O3;
freq = 5e9;
[gammaO24, gammaH2O4] = atmo_absorp(height,Wvd, freq);
gamma4 = gammaO24 + gammaH2O4;
freq = 10e9;
[gammaO25, gammaH2O5] = atmo_absorp(height,Wvd, freq);
gamma5 = gammaO25 + gammaH2O5;
figure
height = height ./1000;
subplot(1,2,1)
semilogy (height, gammaO25,'k',height, gammaO24,'k-.',height, gammaO23,'k:',height,...
    gammaO22,'k.',height, gammaO21,'k--','linewidth', 1.5)
grid
legend('\bf10GHz','5GHz','1GHz','500MHz','300MHz')
ylabel('\bfAtmospheric absorption due to Oxygen - dB')
xlabel('\bfAltitude - Km')
subplot(1,2,2)
semilogy (height, gamma5,'k',height, gamma4,'k-.',height, gamma3,'k:',height,...
    gamma2,'k.',height, gamma1,'k--','linewidth', 1.5)
grid
legend('\bf10GHz','5GHz','1GHz','500MHz','300MHz')
ylabel('\bfTotal atmospheric absorption - dB')
xlabel('\bfAltitude - Km')