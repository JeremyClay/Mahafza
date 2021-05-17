% This program is used to produce Fig. 13.5
clc
close all
clear all
pfa = 1e-9;
nfa = log(2) / pfa;
b = sqrt(-2.0 * log(pfa));
index = 0;
for snr = 0:.1:20
   index = index +1;
   a = sqrt(2.0 * 10^(.1*snr));
   pro(index) = marcumsq(a,b);
   prob205(index) =  pd_swerling5 (pfa, 1, 10, snr);
end
x = 0:.1:20;
plot(x, pro,'k',x,prob205,'k:','linewidth',1.5);
axis([0 20 0 1])
xlabel ('\bfSNR in dB')
ylabel ('\bfProbability of detection')
legend('n_p = 1','n_p = 10')
grid on

