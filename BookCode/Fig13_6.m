% This program is used to reproduce Fig. 13.6
clc
close all
clear all
pfa = 1e-9;
nfa = log(2) / pfa;
b = sqrt(-2.0 * log(pfa));
index = 0;
for snr = 0:.01:22
   index = index +1;
   a = sqrt(2.0 * 10^(.1*snr));
   swer0(index) = marcumsq(a,b);
   swer1(index) =  pd_swerling1 (nfa, 1, snr);
end
x = 0:.01:22;
%figure(10)
plot(x, swer0,'k',x,swer1,'k:','linewidth', 1.5);
axis([2 22 0 1])
xlabel ('\bfSNR in dB')
ylabel ('\bfProbability of detection')
legend('Swerling 0','Swerling I')
grid on






