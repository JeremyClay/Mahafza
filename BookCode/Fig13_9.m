% This program is used to produce Fig. 13.9
clear all
close all
pfa = 1e-6;
nfa = log(2) / pfa;
index = 0;
b = sqrt(-2.0 * log(pfa));
for snr = -10:.5:30
   a = sqrt(2.0 * 10^(.1*snr));
   index = index +1;
   prob1(index) =  pd_swerling1 (nfa, 2, snr);
   prob0(index) =  marcumsq(a,b);
   prob2(index) =  pd_swerling2 (nfa, 2, snr);
end
x = -10:.5:30;
plot(x, prob0,'k',x,prob2,'k:',x,prob1,'k--','linewidth',1.5);
axis([-10 30 0 1])
xlabel ('\bfSNR in dB')
ylabel ('\bfProbability of detection')
legend('Swerling 0','Swerling II','Swerling I')
title('\bfP_f_a =10^-^6;  n_p = 2')
grid on





