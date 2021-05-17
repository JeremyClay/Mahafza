%This program generates Fig. 12.4.
close all
clear all
logpfa = linspace(.01,250,1000);
var = 10.^(logpfa ./ 10.0);
vtnorm =  sqrt( log (var));
semilogx(logpfa, vtnorm,'k','linewidth',1.5)
xlabel('\bflog(P_f_a)')
ylabel('\bfv_T/(2\sigma^2)^1^/^2')

grid
