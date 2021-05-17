% This program generates Fig. 2.9 of text
clc
clear all
close all
ERP = linspace(1,1000,1000);
[Range] = burn_thru (50e3, 35, 10, 5.6e9, .5e-3, 5, 200,500e6, 10, .3, 15,ERP);
figure (1)
plot (10*log10(ERP), Range,'k')
xlabel (' Jammer ERP in dB')
ylabel ('Burnthrough range in Km')
grid