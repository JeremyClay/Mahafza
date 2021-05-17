% Use this program to reproduce Fig. 13.4 of text
clear all
close all
for n= 1: 1:10000
   [pfa1 y1(n)] = threshold(1e4,n);
   [pfa2 y3(n)] = threshold(1e8,n);
   [pfa3 y4(n)] = threshold(1e12,n);
end
n =1:1:10000;
loglog(n,y1,'k',n,y3,'k--',n,y4,'k-.','linewidth',1.5);
xlabel ('\bfNumber of pulses');
ylabel('\bfThreshold')
legend('nfa=10^1^2','nfa=10^8','nfa=10^8')
grid