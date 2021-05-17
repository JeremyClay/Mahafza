% This program is used to produce Fig. 13.11
clc
clear all
close all
pfa = 1e-7;
nfa = log(2) / pfa;
index = 0;
for snr = -10:.5:30
   index = index +1;
   prob1(index) =  pd_swerling1 (nfa, 5, snr);
   prob0(index) =  pd_swerling5 (nfa, 2, 5, snr);
   prob2(index) =  pd_swerling2 (nfa, 5, snr);
   prob3(index) =  pd_swerling3 (nfa, 5, snr);
end
x = -10:.5:30;
plot(x, prob0,'k',x,prob1,'k:',x,prob2,'k--',x,prob3,'k-.','linewidth',1,'linewidth',1.5);
axis([-10 30 0 1])
xlabel ('\bfSNR in dB')
ylabel ('P\bfrobability of detection')
legend('Swerling 0','Swerling I','Swerling II', 'Swerling III')
title('\bfP_f_a =10^-^7;  n_p = 5')
grid on






