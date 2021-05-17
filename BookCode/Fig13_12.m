% This program is used to produce Fig. 13.12 of text
clc
clear all
close all
pfa = 1e-6;
nfa = log(2) / pfa;
index = 0;
for snr = -7:.15:10
   index = index +1;
   prob1(index) =  pd_swerling4 (nfa, 5, snr);
   prob10(index) =  pd_swerling4 (nfa, 10, snr);
   prob25(index) =  pd_swerling4(nfa, 25, snr);
   prob75(index) =  pd_swerling4 (nfa, 75, snr);
end
x = -7:.15:10;
plot(x, prob1,'k',x,prob10,'k.',x,prob25,'k:',x, prob75,'k-.','linewidth',1.5);
xlabel ('\bfSNR in dB')
ylabel ('\bfProbability of detection')
legend('n_p = 5','n_p = 10','n_p = 25','n_p = 75')
grid on
axis tight





