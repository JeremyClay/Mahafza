% This program generates Fig. 2.8 of text
clear all
close all
R = linspace(10,400,5000);
[SIR] = sir (50e3, 35, 10, 5.6e9, 50e-6, 5, R, 200, 50e6, 10, .3);
figure (1)
plot (R, SIR,'k')
xlabel ('Detection range in Km');
ylabel ('S/(J+N) in dB')
grid