% This program can be used to reproduce Fig. 13A.1
clc
close all
clear all
x=linspace(0,20,200);
y1 = gammainc(x,1);
y2 = gammainc(x,3);
y3 = gammainc(x,5);
y4 = gammainc(x,8);
plot(x,y1,'k',x,y2,'k:',x,y3,'k--',x,y4,'k-.','linewidth',1.5)
legend('q = 1','q = 3','q = 5','q = 8')
xlabel('\bfx')
ylabel('\bfIncomplete Gamma function (x,q)')
grid