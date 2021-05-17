% Use this program to reproduce Fig. 13.13 of text
clc
clear all
close all
index = 0.;
for pd = 0.01:.05:1
    index = index + 1;
    [Lf,Pd_Sw5] = fluct_loss(pd, 1e-7,1,1); 
    Lf1(index) = Lf;
    [Lf,Pd_Sw5] = fluct_loss(pd, 1e-7,1,4);
    Lf4(index) = Lf;
    
end
pd = 0.01:.05:1;
figure (3)
plot(pd, Lf1, 'k',pd, Lf4,'K:','linewidth',1.5)
xlabel('\bfProbability of detection')
ylabel('\bfFluctuation loss - dB')
legend('Swerling I & II','Swerling III & IV')
title('P_f_a = 10^-^9, n_p = 1')
grid on




