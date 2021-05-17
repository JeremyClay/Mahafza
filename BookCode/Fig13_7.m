% This program is used to produce Fig. 13.7
clc
clear all
close all
pfa = 1e-6;
nfa = log(2) / pfa;
index = 0;
for snr = -10:.5:30
   index = index +1;
   prob1(index) =  pd_swerling1 (nfa, 15, snr);
   prob0(index) =  pd_swerling5 (nfa, 2, 15, snr);
  end
x = -10:.5:30;
plot(x, prob1,'k',x,prob0,'k:','linewidth',1.5);
axis([-10 30 0 1])
xlabel ('\bfSNR in dB')
ylabel ('\bfProbability of detection')
legend('Swerling I','Swerling 0')
title('\bfP_f_a =10^-^6;  n_p=5')
grid




