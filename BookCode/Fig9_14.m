% reproduce Fig 9.14 xyz of text
clc
clear all
close all
P = linspace(.001,.999,10000);
sigmam = -47.75;
a =3.3;
sigmao = sigmam + 1.5917 * a + 10 * a .* log10(-log((1-P)));
figure
index = find (P >=.2 & P <=.9);
plot(sigmao(index),P(index),'k','linewidth',1.5)
hold on
sigmam = -38.;
a =1.75;
sigmao = sigmam + 1.5917 * a + 10 * a .* log10(-log((1-P)));
index = find (P >=.20 & P <=.9);
plot(sigmao(index),P(index),'k:','linewidth',1.5)
sigmam = -29.8;
a =1.1;
sigmao = sigmam + 1.6917 * a + 10 * a .* log10(-log((1-P)));
index = find (P >=.2 & P <=.9);
plot(sigmao(index),P(index),'k-.','linewidth',1.5);
hold off
axis([-75 0 0 1])
legend('a=3.3','a=1.75','a=1.1')
xlabel('\bf\sigma^o - Backscatter coefficient - dB') 
ylabel('\bf Probability of clutter density is less than \sigma^o')
grid
