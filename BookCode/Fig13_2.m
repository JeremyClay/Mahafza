% This program is used to produce Fig. 13.2
% It uses the function "improv_fac". 
clc
clear all
close all
Pfa = [1e-2, 1e-6, 1e-8, 1e-10];
Pd = [.5 .8 .95 .99];
np = linspace(1,1000,10000);
I(1,:) = improv_fac (np, Pfa(1), Pd(1));
I(2,:) = improv_fac (np, Pfa(2), Pd(2));
I(3,:) = improv_fac (np, Pfa(3), Pd(3));
I(4,:) = improv_fac (np, Pfa(4), Pd(4));
index = [1 2 3 4];
L(1,:) = 10.*log10(np) - I(1,:);
L(2,:) = 10.*log10(np) - I(2,:);
L(3,:) = 10.*log10(np) - I(3,:);
L(4,:) = 10.*log10(np) - I(4,:);
subplot(2,1,2)
semilogx (np, L(1,:), 'k:', np, L(2,:), 'k-.', np, L(3,:), 'k-.', np, L(4,:), 'k','linewidth',1.5)
xlabel ('\bfNumber of pulses');
ylabel ('\bfIntegration loss in dB')
axis tight
grid
subplot(2,1,1)
semilogx (np, I(1,:), 'k:', np, I(2,:), 'k-.', np, I(3,:), 'k--', np, I(4,:), 'k','linewidth',1.5)
%set (gca,'xtick',[1 2 3 4 5 6 7 8  10 20 30 100]);
xlabel ('\bfNumber of pulses');
ylabel ('\bfImprovement factor in dB')
legend ('P_D=.5, P_f_a=10^-^2','P_D=.8, P_f_a=10^-^6','P_D=.95, P_f_a=10^-^8','P_D=.99, P_f_a=10^-^1^0');
grid
axis tight